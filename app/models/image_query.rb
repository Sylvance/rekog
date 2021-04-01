class ImageQuery < ApplicationRecord
  belongs_to :person
  has_one_attached :image

  before_update :set_match_parameters

  private

    def set_match_parameters
      self.is_match = queried_is_match
      self.percentage_match = queried_percentage_match
    end

    def queried_is_match
      queried_percentage_match > 90 ? true : false
    end

    def queried_percentage_match
      aws_rekog_client.matches.first.similarity
    end

    def aws_rekog_client
      ImageQueriesHelper::AwsRekognitionClient.new(image, person.image)
    end
end
