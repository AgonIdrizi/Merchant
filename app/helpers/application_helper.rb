module ApplicationHelper
  
  def send_create_order_mail(order, email)
    OrderCreateMailer.order_create_email(order, email).deliver
  end
end
