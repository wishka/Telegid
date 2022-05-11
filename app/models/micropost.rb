class Micropost < ApplicationRecord
  mount_uploader :image, ImageUploader
  include PgSearch
  validates :title, :content, :image, presence: true
end
