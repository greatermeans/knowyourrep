class Politician < ApplicationRecord
  has_many :representatives
  has_many :senators
  has_many :messages
end
