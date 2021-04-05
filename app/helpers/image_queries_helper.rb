module ImageQueriesHelper
  class AwsRekognitionClient
    def initialize(source_image, target_image)
      @credentials = Aws::Credentials.new(
        ENV['AWS_ACCESS_KEY_ID'],
        ENV['AWS_SECRET_ACCESS_KEY']
      )

      @source_image = source_image
      @target_image = target_image
    end

    def matches
      @matches ||= compare.face_matches
    end

    def detected
      @detected||= detect.face_details
    end

    def matches_to_s
      matches.each do |face_match|
        position   = face_match.face.bounding_box
        similarity = face_match.similarity
        puts "The face at: #{position.left}, #{position.top} matches with #{similarity} % confidence"
      end
    end

    def detected_to_s
      puts "Detected faces for: #{photo}"
      detected.each do |face_detail|
        low  = face_detail.age_range.low
        high = face_detail.age_range.high
        puts "The detected face is between: #{low} and #{high} years old"
        puts "All other attributes:"
        puts "  bounding_box.width:     #{face_detail.bounding_box.width}"
        puts "  bounding_box.height:    #{face_detail.bounding_box.height}"
        puts "  bounding_box.left:      #{face_detail.bounding_box.left}"
        puts "  bounding_box.top:       #{face_detail.bounding_box.top}"
        puts "  age.range.low:          #{face_detail.age_range.low}"
        puts "  age.range.high:         #{face_detail.age_range.high}"
        puts "  smile.value:            #{face_detail.smile.value}"
        puts "  smile.confidence:       #{face_detail.smile.confidence}"
        puts "  eyeglasses.value:       #{face_detail.eyeglasses.value}"
        puts "  eyeglasses.confidence:  #{face_detail.eyeglasses.confidence}"
        puts "  sunglasses.value:       #{face_detail.sunglasses.value}"
        puts "  sunglasses.confidence:  #{face_detail.sunglasses.confidence}"
        puts "  gender.value:           #{face_detail.gender.value}"
        puts "  gender.confidence:      #{face_detail.gender.confidence}"
        puts "  beard.value:            #{face_detail.beard.value}"
        puts "  beard.confidence:       #{face_detail.beard.confidence}"
        puts "  mustache.value:         #{face_detail.mustache.value}"
        puts "  mustache.confidence:    #{face_detail.mustache.confidence}"
        puts "  eyes_open.value:        #{face_detail.eyes_open.value}"
        puts "  eyes_open.confidence:   #{face_detail.eyes_open.confidence}"
        puts "  mouth_open.value:       #{face_detail.mouth_open.value}"
        puts "  mouth_open.confidence:  #{face_detail.mouth_open.confidence}"
        puts "  emotions[0].type:       #{face_detail.emotions[0].type}"
        puts "  emotions[0].confidence: #{face_detail.emotions[0].confidence}"
        puts "  landmarks[0].type:      #{face_detail.landmarks[0].type}"
        puts "  landmarks[0].x:         #{face_detail.landmarks[0].x}"
        puts "  landmarks[0].y:         #{face_detail.landmarks[0].y}"
        puts "  pose.roll:              #{face_detail.pose.roll}"
        puts "  pose.yaw:               #{face_detail.pose.yaw}"
        puts "  pose.pitch:             #{face_detail.pose.pitch}"
        puts "  quality.brightness:     #{face_detail.quality.brightness}"
        puts "  quality.sharpness:      #{face_detail.quality.sharpness}"
        puts "  confidence:             #{face_detail.confidence}"
        puts "------------"
        puts ""
      end
    end

    private

    attr_reader :credentials, :source_image, :target_image

    def compare
      @compare ||= client.compare_faces(compare_attrs)
    end

    def detect
      @detect ||= client.detect_faces(detect_attrs)
    end

    def client
      @client ||= Aws::Rekognition::Client.new(credentials: credentials)
    end

    def detect_attrs
      {
        image: {
          bytes: source_image,
        },
        attributes: ['ALL']
      }
    end

    def compare_attrs
      {
        source_image: {
          bytes: source_image,
        },
        target_image: {
          bytes: target_image,
        },
        similarity_threshold: 70
      }
    end
  end

  class QueryImages
    def initialize(image_query)
      @image_query = image_query
    end

    def run
      set_queried_params
      image_query.save
    end

    private

    attr_reader :image_query

    def set_queried_params
      image_query.is_match = queried_is_match
      image_query.percentage_match = queried_percentage_match
      image_query.matches_meta = queried_matches_meta
      image_query.detected_meta = queried_detected_meta
    end

    def queried_is_match
      queried_percentage_match > 90 ? true : false
    end

    def queried_percentage_match
      aws_rekog_client.matches.first.similarity
    end

    def queried_matches_meta
      aws_rekog_client.matches_to_s
    end

    def queried_detected_meta
      aws_rekog_client.detected_to_s
    end

    def aws_rekog_client
      processed_source_image = image_query.image.variant(resize_to_limit: [200, 200]).processed
      processed_target_image = image_query.person.image.variant(resize_to_limit: [200, 200]).processed
      source_image = processed_source_image.download
      target_image = processed_target_image.download
      AwsRekognitionClient.new(source_image, target_image)
    end
  end
end
