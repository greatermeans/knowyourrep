class SenateSeat < ApplicationRecord
	belongs_to :politician
	belongs_to :state
end
