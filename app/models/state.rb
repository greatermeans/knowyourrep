class State < ApplicationRecord

	has_many :users
	has_many :districts
	has_many :senate_seats
	has_many :representative_seats, through: :districts

end
