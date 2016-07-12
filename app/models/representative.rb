class RepresentativeSeat < ApplicationRecord
  belongs_to :politician
  belongs_to :district
  belongs_to :state, through: :distrcit
end
