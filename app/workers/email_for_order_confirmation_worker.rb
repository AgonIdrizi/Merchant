class EmailForOrderConfirmationWorker
  include Sidekiq::Worker

  def perform(order_id,email)
  	order = Order.find_by(id: order_id)
  	OrderCreateMailer.order_create_email(order, email).deliver
  end
end
