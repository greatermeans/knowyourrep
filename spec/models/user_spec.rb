require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'User' do
    let(:user) { FactoryGirl.create :user }
    it 'can be created' do
      expect(user).to be_valid
    end
  end


end