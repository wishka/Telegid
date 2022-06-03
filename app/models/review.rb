class Review < ApplicationRecord
  validates :stars,  presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :content,  presence: true
  belongs_to :customer
end
