class ChargesController < ApplicationController
  before_action :load_cart, only: [:new,:create]
  def new
    @charges = Charge.new
    @order_id = session[:order_id]
  end

  def create
    order = Order.find_by(id: session[:order_id])
    amount = order.total
    @charges = Charge.new(charge_params)
    
    if @charges.save
      if @charges.process
        session[:order_id]=nil
        order.update_attributes(status: 'needs_packing')
        flash[:success] =  "Successfully charged $#{sprintf("%.2f", amount)} to the credit card #{@charges.last4}"
        redirect_to order and return
      end
    end
    render 'new'
    
   
  end

  private
  def charge_params
    params.require(:charge).permit(:first_name, :last_name, :credit_card_number, :expiration_month, :expiration_year, :card_security_code,:order_id )
    
  end
end
