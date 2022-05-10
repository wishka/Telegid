class Micropost < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :title, :content, :image, presence: true
end
