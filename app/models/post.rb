class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :room
  #default_scope -> { order(created_at: :desc) }
  validates :customer_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  
end
