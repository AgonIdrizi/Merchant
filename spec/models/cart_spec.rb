require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "can create a cart" do
  	cart = FactoryGirl.create(:cart)

  	expect(cart.persisted?).to be_truthy
  end

  it "can create a cart with multipe items" do
  	cart = FactoryGirl.create(:cart,:with_order_items)
  	expect(cart.order_items.length).to eq(5)
  end
end
