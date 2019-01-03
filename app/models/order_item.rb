class OrderItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  
  validates :product_id, presence: true

  def subtotal
  	quantity * product.price
  end
end
