class ChargesController < ApplicationController
  require "active_merchant/billing/rails"
  def new
    @order_id = charges_params[:order_id]
    
  end

  def create
    #debugger
    
    @order = Order.find_by(id: charges_params[:order_id])
    gateway = ActiveMerchant::Billing::SecurionPayGateway.new(:secret_key => ENV['SECURION_PAY_GATEWAY_SECRET'])

    # ActiveMerchant accepts all amounts as Integer values in cents
    amount = @order.total  # $10.00

    # The card verification value is also known as CVV2, CVC2, or CID
    credit_card = ActiveMerchant::Billing::CreditCard.new(
                :first_name         => 'Bob',
                :last_name          => 'Bobsen',
                :brand              => charges_params[:brand],
                :number             => charges_params[:credit_card_number].to_i,
                :month              => charges_params[:mm].to_i,
                :year               => charges_params[:yy].to_i,
                :verification_value => charges_params[:cvc].to_i)

    # Validating the card automatically detects the card type

    
    # Capture $10 from the credit card
    response = gateway.purchase(amount, credit_card)
    
      if response.success?
        #sent email with (sidekiq), that your order is paid and will be ready for shipping
        flash[:success] =  "Successfully charged $#{sprintf("%.2f", amount)} to the credit card #{credit_card.display_number}"
        redirect_to @order
      else
        #raise StandardError  response.message
        flash[:error] = response.message
        render 'new'
      end
   debugger
   
  end

  private
  def charges_params
    params.permit(:utf8, :authenticity_token, :order_id, :token, :credit_card_number, :brand, :mm, :yy, :cvc)
  end
end
