class Address < ApplicationRecord
  belongs_to :user ,optional: true
  has_many :orders_shipping_addresses, class_name: 'Order', foreign_key: :shipping_address_id
  has_many :orders_billing_addresses, class_name: 'Order', foreign_key: :billing_address_id

  

  validates :line1, :city, :state, :zip, presence: :true 
  validates :state, format: {with: /[A-Z]{2}/}
  validates :zip, format: {with: /\d{5}/}
  

  def to_s
    [line1, line2, "#{city}, #{state}, #{zip}"].compact.join(", ")
  end

  def default_shiping_address
  end
end
