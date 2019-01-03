class Cart < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  belongs_to :user
  def total
  	order_items.map(&:subtotal).sum
  end
end
