class RepresentativeSeat < ApplicationRecord

	belongs_to :district
	belongs_to :politician
	
end
