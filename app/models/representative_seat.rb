class RepresentativeSeat < ApplicationRecord
  belongs_to :politician
  belongs_to :district
end
