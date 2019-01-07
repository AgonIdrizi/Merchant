class OrdersController < ApplicationController
	
  #before_action :check_if_cart_is_empty_or_session_cart_id_is_nil , only: [:create,:confirm]
  before_action :set_order_id ,only: [:show, :edit, :update, :destroy, :confirm]
  before_action :load_cart , only: [:create]
  #before_action :access_only_your_order
	def show
	 
	end
	def new
	  @order = Order.new
	end
	def create

	  @order = Order.new(order_params)
      #debugger
      respond_to do |format|
        if @order.save
          @cart.order_items.each do |order_item|
            order_item.order_id = @order.id
            order_item.save
          end
          session[:cart_id] = nil
          session[:user_id] = nil
          @cart.destroy 
          
          format.html { redirect_to @order, notice: 'Order was successfully created.' }
          format.json { render action: 'show', status: :created, location: @order }
        else
          format.html { redirect_to confirm_path, notice: "#{@order.errors}" }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end
    def update
      respond_to do |format|
        if @order.update(order_params.merge(status: 'submitted'))
          format.html { redirect_to confirm_order_path(@order), notice: 'Order was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    def confirm
      @address = current_user ? current_user.addresses.new : Address.new

      @order = current_user ? current_user.orders.new : Order.new
      @cart = Cart.find_by(id: session[:cart_id])
     #debugger
    end
	

	def destroy
	  @order.destroy

	  respond_to do |format|
	  	format.html { redirect_to root_path }
	  	format.json { head :no_content }
	  end
	end

	private

	def order_params
      params.permit(:user_id, :status,:shipping_address_id)
    end

	def set_order_id
	  @order = Order.find_by(id: params[:id])
    #debugger
	end
  #before creating a order, we check if there are items in cart, if there are no item we redirect
  def check_if_cart_is_empty_or_session_cart_id_is_nil

    @cart = Cart.find_by(id: session[:cart_id]) if session[:cart_id] =! nil
    if session[:cart_id] == nil && @cart.order_items.empty?
      redirect_to root_path
       
      flash.notice = "Please add any product before placing an order"
      redirect_to root_path
    else
    end
   
  end

  #dont allow users to acccess other orders, by checking the id of order in the session[:order_id] and by checking param[:id] of URI to which user is navigating
  def access_only_your_order
    #debugger
    if params[:id].to_i  != session[:order_id]
      redirect_to root_path
    end
  end
end
