class Telechannel < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name,  presence: true, length: { maximum: 50 }
  validates :content,  presence: true
  validates :image,  presence: true
  before_save   :downcase_name
  include PgSearch
  pg_search_scope :search_everywhere, against: [:name, :content]


  private

  def downcase_name
    self.name = name.downcase
  end
end
