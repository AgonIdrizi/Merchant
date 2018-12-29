require 'rails_helper'

RSpec.describe Address, type: :model do
  it "can create  address" do
  	address = FactoryGirl.create(:address)
  	expect(address.line1).to eq "Gostivarska 26"
  end

  it "can't create address without line1" do
  	address = FactoryGirl.build(:address,line1: nil)
  	address.valid?
  	expect(address.errors[:line1]).to include "can't be blank"

  end

  #it "can't create address without user_id" do
  	#address = FactoryGirl.build(:address,user_id: nil)
  	#address.valid?
  	#expect(address.errors[:user_id]).to include "can't be blank"

  #end

  it "can't create address without zip" do
  	address = FactoryGirl.build(:address,zip: nil)
  	address.valid?
  	expect(address.errors[:zip]).to include "can't be blank"

  end

  it "can't create address without valid format zip" do
  	address = FactoryGirl.build(:address,zip: 1200)
  	address.valid?
  	expect(address.errors[:zip]).to include "is invalid"

  end

  it "can't create address without state" do
  	address = FactoryGirl.build(:address,state: nil)
  	address.valid?
  	expect(address.errors[:state]).to include "is invalid"

  end

  it "can't create address without valid format state" do
  	address = FactoryGirl.build(:address,state: nil)
  	address.valid?
  	expect(address.errors[:state]).to include "is invalid"

  end

end
