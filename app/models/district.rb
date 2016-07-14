class District < ApplicationRecord

	has_many :users
	has_one :representative_seat
	belongs_to :state



end
