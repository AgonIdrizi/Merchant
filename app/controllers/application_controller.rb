class ApplicationController < ActionController::Base
  
 def load_order 
 	#
 	if current_user.present?
 	  load_order_for_registered_users
 	else
   	#debugger
	  @order = Order.find_or_initialize_by(id: session[:order_id], status: "unsubmitted")
	  
	  if @order.new_record? #if is not persisted in db then enter the block and save it to db
        @order.save!
        session[:order_id] = @order.id
      end
 	end
  end
  def load_order_for_registered_users
  	
     if session[:order_id].present? && Order.find_by(id: session[:order_id]).order_items.present?
     	#if  Order.where(user_id: current_user.id, status: "unsubmitted").last.order_items.present?
     	@order = current_user.orders.first_or_create(user_id: current_user.id, status: "unsubmitted") 
     	debugger
     	  #we iterate through order_items of the order which was in previous session, 
     	  #and we add order items to our current_user order (if order_item is present 
     	  #in current_user order then we update quantity of that order_item)
     	  Order.find_by(id: session[:order_id]).order_items.each do |order_item|
			if @order.order_items.find_by(product_id: order_item.product_id).product_id == order_item.product_id
			  @order.order_items.find_by(product_id: order_item.product_id).update_attributes(quantity: @order.order_items.find_by(product_id: order_item.product_id).quantity + 1)
			 	
			else
			   	
			order_item.update_attributes(order_id: @order.id)
			end
     		  
     		  #debugger
     	end
     	  session[:order_id] = @order.id
       # end
    else #if previous session doesnt exists
      @order = Order.where(user_id: current_user.id, status: "unsubmitted").last
    end
     
 
  end
end
