class OrderCreateMailer < ApplicationMailer
	default from: 'admin@mjalti.com'

	def order_create_email(order, email)
	  @order = order
	  @email =  email
	  mail(to: email, subject: "Order #{@order.id} was submitted")
	end
end
