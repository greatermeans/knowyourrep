class User < ApplicationRecord
  has_secure_password
  belongs_to :district
  has_many :messages
  include DistrictFinder
  
  # has_many :politicians, through: :messages

  # need method to find user's rep/sen seats

  def set_district
    get_district
  end

  def representative
    binding.pry
    district.representative_seat.politician
  end

  def senator1
    state.senate_seats[0].politician
  end

  def senator2
    state.senate_seats[1].politician
  end
end

#find or create by states / districts