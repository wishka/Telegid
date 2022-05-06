class Room < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :posts
  has_many :customers, through: :posts
end
