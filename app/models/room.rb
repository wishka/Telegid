class Room < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name,  presence: true, length: { maximum: 50 }
  validates :content,  presence: true
  has_many :posts, dependent: :delete_all
  has_many :customers, through: :posts
  before_save   :downcase_name
  include PgSearch
  pg_search_scope :search_everywhere, against: [:name, :content]

  private

  def downcase_name
    self.name = name.downcase
  end
end
