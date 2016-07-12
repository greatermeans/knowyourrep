class District < ApplicationRecord
  belongs_to :state
  has_one :representative_seat
  has_many :users
  


end
