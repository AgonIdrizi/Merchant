require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "can create a cart" do
  	order = FactoryGirl.create(:order)

  	expect(order.persisted?).to be_truthy
  end
end
