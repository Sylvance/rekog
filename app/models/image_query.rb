class ImageQuery < ApplicationRecord
  belongs_to :person
  has_one_attached :image
end
