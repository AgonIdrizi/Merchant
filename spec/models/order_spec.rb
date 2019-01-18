require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "creating order" do
    before do
      @order = FactoryGirl.create(:order)
      @order2 = FactoryGirl.create(:order, user_id: nil)
    end
    
    it "can create a order" do
  	  
      #address = order.address.create(:address)
  	  expect(@order.status).to eq "Unsubmitted"
    end

    it "can create a order without user_id" do
  	  
  	  expect(@order2.user_id).to be nil
    end

    xit "can have more or to order-item" do
  	  product = FactoryGirl.create(:product)
  	  order = FactoryGirl.create(:order, user_id: nil)

      order.order_items.create(product_id: product.id, quantity: 1)
  	  expect(order.order_items.length).to eq 1
    end
  end


end
