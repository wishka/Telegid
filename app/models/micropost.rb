class Micropost < ApplicationRecord
  mount_uploader :image, ImageUploader
  include PgSearch
  validates :title, :content, :image, presence: true
  pg_search_scope :search_everywhere, against: [:title]
end
