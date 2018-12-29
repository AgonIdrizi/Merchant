require 'rails_helper'

RSpec.describe User, type: :model do
  it "can create a user" do
  	user = FactoryGirl.create(:user)

  	expect(user.email).to eq("agon@agon.com")
  end

  it 'doesnt allow duplicate emails' do
  	user = FactoryGirl.create(:user)
  	other_user  = FactoryGirl.build(:user, email: user.email)
  	other_user.valid?
  	expect(other_user.errors[:email]).to include("has already been taken")
  end
end
