class District < ApplicationRecord
  belongs_to :state
  has_one :representative
  has_many :users
  


end
