class State < ApplicationRecord
  has_many :senate_seats
  has_many :districts
  has_many :representative_seats, through: :districts
  has_many :users
end
