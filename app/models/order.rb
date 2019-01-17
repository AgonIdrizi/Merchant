class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :billing_address, class_name: 'Address' ,optional: true
  belongs_to :shipping_address, class_name: 'Address'
  

  

  def total
  	order_items.map(&:subtotal).sum
  end

  
end
