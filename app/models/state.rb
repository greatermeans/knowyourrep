class State < ApplicationRecord
  has_many :senators
  has_many :districts
  has_many :representatives, through: :districts
  has_many :users
end
