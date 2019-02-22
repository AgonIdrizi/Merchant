module UsersHelper
  def user_orders(user)
  	user.orders.present? ? user.orders : 'There seems not to be any order here' 
  end
end
