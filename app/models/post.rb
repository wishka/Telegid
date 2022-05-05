class Post < ApplicationRecord
  searchkick
  belongs_to :customer
  belongs_to :room
end
