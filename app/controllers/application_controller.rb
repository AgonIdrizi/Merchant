class ApplicationController < ActionController::Base



 def load_cart 
  if current_user
    @cart = Cart.find_or_create_by(user_id: current_user.id)
    #debugger
      session[:cart_id] = @cart.id
  else
	  @cart = Cart.find_or_initialize_by(id: session[:cart_id])
    @cart
	    if @cart.new_record? #if is not persisted in db then enter the block and save it to db
          @cart.save!
          session[:cart_id] = @cart.id
      end
  end

  end
  ## this method transform session
  def transfer_order_items_from_previous_session
    if session[:cart_id].present? && Cart.find_by(id: session[:cart_id]).order_items.present?
      
      #debugger
      @cart = Cart.first_or_create(user_id: current_user.id)
      
        #we iterate through order_items of the cart which was in previous session, 
        #and we add order items to our current_user cart (if order_item is present 
        #in current_user cart then we update quantity of that order_item)
        #debugger
        Cart.find_by(id: session[:cart_id]).order_items.each do |order_item|
          if @cart.order_items.find_by(product_id: order_item.product_id).present?

          @cart.order_items.find_by(product_id: order_item.product_id).update_attributes(quantity: @cart.order_items.find_by(product_id: order_item.product_id).quantity + order_item.quantity)
         
          else
          
         order_item.update_attributes(cart_id: @cart.id)
          end 
        end
        session[:cart_id] = @cart.id
       # end
    end
  end

  
     
  
  
end
