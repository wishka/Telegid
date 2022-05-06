class Room < ApplicationRecord
  has_many :posts
  has_many :customers, through: :posts
end
