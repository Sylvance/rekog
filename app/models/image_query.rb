class ImageQuery < ApplicationRecord
  belongs_to :person
  has_one_attached :image

  before_update: compute_match

  def self.compute_match
    is_match = person.image == image
    save
  end
end
