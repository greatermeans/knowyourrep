class User < ApplicationRecord
  has_many :messages
  belongs_to :district
  belongs_to :state
  belongs_to :representative
  has_many :senators
end
