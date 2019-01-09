class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :billing_address, class_name: 'Address' ,foreign_key: 'billing_address_id',optional: true
  belongs_to :shipping_address, class_name: 'Address', foreign_key: 'shipping_address_id'

  

  

  def total
  	order_items.map(&:subtotal).sum
  end
end
