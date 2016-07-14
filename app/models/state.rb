class State < ApplicationRecord

	has_many :districts
	has_many :senate_seats
	has_many :representative_seats, through: :districts
	has_many :users, through: :districts

end
