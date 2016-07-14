class User < ApplicationRecord
  has_secure_password
  belongs_to :district
  has_many :messages
  # belongs_to :state
  include DistrictFinder

  attr_accessor :state
  
  # has_many :politicians, through: :messages

  # need method to find user's rep/sen seats

  # def state
  #   self.state
  #   # district.nil? ? '' : district.state
  # end

  def state=(state)
    @state = State.find(state)
  end


  def set_district
    get_district
  end

  def representative
    district.representative_seat.politician
  end

  def senator1
    district.state.senate_seats[0].politician
  end

  def senator2
    district.state.senate_seats[1].politician
  end
end

#find or create by states / districts