class SenateSeat < ApplicationRecord

	belongs_to :state
	belongs_to :politician
	
end
