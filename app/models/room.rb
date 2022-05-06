class Room < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :posts, dependent: :delete_all
  has_many :customers, through: :posts
end
