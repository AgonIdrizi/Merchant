require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe "#show" do
  	context "as signed user" do
  	  before do
  	    @user = FactoryGirl.create(:user)
  	    @cart = @user.create_cart
  	  end

  	  it "responds successfully" do
  	  	sign_in @user
  	  	session[:cart_id] = @cart.id
  	  	get(:show, params: {id: session[:cart_id]})
  	  	expect(response).to be_success
  	  end
  	end

  	context "as a guest" do
  	  before do
  	    @cart = Cart.create(user_id: nil)
  	    session[:cart_id] = @cart.id
  	  end
  	  it "redirects to cart page" do
  	  	get :show, params: {id: session[:cart_id]}
  	  	puts response.location
  	  	expect(response).to be_success
  	  end
  	end
  end

  describe "create" do
  end
end
