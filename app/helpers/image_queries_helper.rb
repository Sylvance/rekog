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
      compare.face_matches
    end

    def to_s
      compare.face_matches.each do |face_match|
        position   = face_match.face.bounding_box
        similarity = face_match.similarity
        puts "The face at: #{position.left}, #{position.top} matches with #{similarity} % confidence"
      end
    end

    private

    attr_reader :credentials, :source_image, :target_image

    def compare
      @compare ||= client.compare_faces(attrs)
    end

    def client
      @client ||= Aws::Rekognition::Client.new(credentials: credentials)
    end

    def attrs
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
end
