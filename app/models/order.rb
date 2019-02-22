class Order < ApplicationRecord
  enum status_of_order: [:unsubmitted, :needs_payment, :needs_packing, :needs_shipping, :shipped ]
  
  has_many :order_items, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :billing_address, class_name: 'Address' ,optional: true
  belongs_to :shipping_address, class_name: 'Address'
  has_one :charge

  

  def total
  	order_items.map(&:subtotal).sum
  end

  
end
