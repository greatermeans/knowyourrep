class User < ApplicationRecord
  has_secure_password
  belongs_to :district
  has_many :messages
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, :street_address, :state, :city, :name

  include DistrictFinder

  attr_accessor :state

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


# require_relative '../rails_helper.rb'
# require_relative '../spec_helper.rb'

# RSpec.describe User, type: :model do

#   describe 'User' do
#     let(:user) { FactoryGirl.create :user }
#     it 'can be created' do
#       expect(user).to be_valid
#     end
#   end


# end


# FactoryGirl.define do
#   factory :user do
#     name "Fred"
#     email "fred@fred.com"
#     street_address "14 bushy ridge rd."
#     city "Westport"
#     state "State.find_by(name: 'Connecticut')"
#     password "one"
#     district_id "583"
#   end
# end


#find or create by states / districts