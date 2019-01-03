require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it "can create an order item" do
  	order_item = FactoryGirl.create(:order_item)
  	expect(order_item).to be_truthy
  end

  it "can't create an order-item without order" do
  	order_item = FactoryGirl.build(:order_item, cart_id: nil)
  	order_item.save
  	expect(order_item.persisted?).to be_falsey
  end
end
