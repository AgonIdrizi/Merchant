class OrderItemsController < ApplicationController
	before_action :load_cart, only: [:create, :update] 
	
	before_action :set_order_item, only: [:edit, :destroy, :update]

	def create
		#quantity ||= +1 if @order.order_items.
	  #@order_item = @order.order_items.new(quantity: 1, product_id: params[:product_id])
	  @order_item = @cart.order_items.find_or_initialize_by(product_id: params[:product_id])
	  
	  #@order_item.quantity ||= +1 

	  if @order_item.quantity == 0
	  	@order_item.quantity = 1
	  else
	  	@order_item.quantity +=1 
	  end
	  #debugger
	  respond_to do |format|
	    if @order_item.save
	  	  format.html { redirect_to @cart, notice: 'Successfully added product to cart.'}
	  	  format.json { render action: 'show', status: :created, location: @order_item }
	  	else
	  	  format.html { render action: 'new' }
          format.json { render json: @order_item.errors, status: :unprocessable_entity }
	    end
	  end
	  
	end

	def edit
	end
	def update
	   
    	respond_to do |format|
      if order_item_params[:quantity].to_i == 0
        @order_item.destroy
        format.html { redirect_to @order_item.cart, notice: 'Item was deleted from your cart.' }
        format.json { head :no_content }
      elsif @order_item.update(order_item_params)
      	
        format.html { redirect_to @order_item.cart, notice: 'Successfully updated the order item.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
	  @order_item.destroy
	  respond_to do |format|
	  	format.html { redirect_to @order_item.cart }
	  	format.json { head :no_content }
	  end
	end

	private

	def order_item_params
	  params.require(:order_item).permit(:product_id,:cart_id, :quantity)
	end

	def set_order_item
      @order_item = OrderItem.find(params[:id])
    end


end
