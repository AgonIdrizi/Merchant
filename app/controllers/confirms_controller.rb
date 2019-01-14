class ConfirmsController < ApplicationController
	before_action :load_cart , only: [ :new]
	
  def new
  	@orderform = OrderForm.new

  end

  def create
  	@cart = Cart.find_by(id: session[:cart_id])
  	@orderform = OrderForm.new(params[:order_form])
  
  	if @orderform.save
  		#we should find a way to update line_item (order id to the order just created)
  		#sent email that order is created, with number of order
  		#@cart.destroy
  		session[:cart_id] = nil
  	  redirect_to new_charge_path, notice: 'Order was screated'
  	else
  	  flash.now[:danger] = @orderform.errors.full_messages
  	  render :new
  	end
  end

  

end
