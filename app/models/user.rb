class User < ApplicationRecord
  has_secure_password
  has_many :messages
  belongs_to :district
  belongs_to :state
  has_one :representative_seat
  has_many :senator_seats
end
