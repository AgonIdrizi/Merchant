class Cart < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :user, optional: true
  def total
  	order_items.map(&:subtotal).sum
  end
end
