class ApplicationController < ActionController::Base
  
 def load_order 
 	#if user logins and there is no ordr_id in session then create a order and attach it to user
   if current_user.present? && session[:order_id].nil?
     @order = Order.find_or_create_by(user_id: current_user.id, status: 'unsubmitted')
   else
	  @order = Order.find_or_initialize_by(id: session[:order_id], status: "unsubmitted")
	 
	  if @order.new_record?
	  	  @order.save
	  	  session[:order_id] = @order.id
	  end
	  #check if item exists in order (then just update the count)
	end
	#debugger
  end
end
