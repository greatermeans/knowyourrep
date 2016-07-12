class Politician < ApplicationRecord
  has_many :representative_seats
  has_many :senator_seats
  has_many :messages
  belongs_to :state
end
