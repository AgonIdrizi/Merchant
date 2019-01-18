require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  describe "create" do
  	context "with one quantity" do
  	  before do
  	    @cart = Cart.create(user_id: nil)
  	    session[:cart_id] = @cart.id
  	    @product = FactoryGirl.create(:product)
  	  end
  	  it "creates sucessfully" do
  	    post :create, params: {product_id: @product.id, cart_id: @cart.id, quantity: 1}
  	    order_item = OrderItem.last
  	    expect(order_item.quantity).to eq(1)
  	    expect(order_item.cart_id).to eq(@cart.id)
  	  end
  	end
  	
  end

  describe "#update" do
  	before do
  	  @cart = Cart.create(user_id: nil)
  	  session[:cart_id] = @cart.id
  	  @product = FactoryGirl.create(:product)
  	  @order_item = OrderItem.create(product_id: @product.id, cart_id: @cart.id, quantity: 1)
  	 end
  	 xit "updates quantity of order_item" do
  	   put :update,params: {id: @order_item.id, quantity: 3}
  	   expect(@order_item.quantity).to eq(3)
  	 end
  end
end
