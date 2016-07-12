class Politician < ApplicationRecord
  has_many :representatives
  has_many :senators
end
