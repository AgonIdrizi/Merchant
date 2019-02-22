class ConfirmsController < ApplicationController
	before_action :load_cart , only: [:new, :create]
	before_action :check_cart_items, only:[:new, :create]
  def new
  	@confirmform = ConfirmForm.new(@cart)
  end

  def create
    #we gather information for new order, through 'ConfirmForm' form object and do validations for different models
  	@confirmform = ConfirmForm.new(params[:confirm_form], @cart)
  	
  	  if @confirmform.save
  		  #sent email that order is created, with number of order, background job with sidekiq
  		  session[:email] = @confirmform.email #we will need email of non-registered users in payment form?
  		  EmailForOrderConfirmationWorker.perform_async(@confirmform.order.id, session[:email])
        @cart.destroy
  		  session[:cart_id] = nil
        session[:order_id] = @confirmform.order.id
  		  respond_to do |format|
  	      format.html {redirect_to charges_new_path, notice: 'Order was created' }
  	  	end
  	  else
  	    flash.now[:danger] = @confirmform.errors.full_messages
  	    render :new
  	  end
  end

  private
  	#carts that are empty cant create a order, so we redirect empty carts to root_path
    def check_cart_items
      if !@cart.order_items.present?
      	flash[:danger] = "You need to add items to card to make a new order"
        redirect_to root_path
  	  end
    end
  

end
