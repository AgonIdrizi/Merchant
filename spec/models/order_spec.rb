require 'rails_helper'

RSpec.describe Order, type: :model do
  it "can create a order" do
  	order = FactoryGirl.create(:order)

  	expect(order.status).to eq "Unsubmitted"
  end

  it "can create a order without user_id" do
  	order = FactoryGirl.create(:order, user_id: nil)
  	expect(order.user_id).to be nil
  end

  xit "can have more or to order-item" do
  	product = FactoryGirl.create(:product)
  	order = FactoryGirl.create(:order, user_id: nil)

    order.order_items.create(product_id: product.id, quantity: 1)
  	expect(order.order_items.length).to eq 1
  end


end
