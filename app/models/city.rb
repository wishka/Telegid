class City < ApplicationRecord
  belongs_to :room

  City.order(:name).to_a
end
