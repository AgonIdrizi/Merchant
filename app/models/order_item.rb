class OrderItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :order, optional: true
  
  validates :product_id, presence: true

  def subtotal
  	quantity * product.price
  end
end
