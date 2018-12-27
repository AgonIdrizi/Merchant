class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :address, optional: true

  def total
  	order_items.map(&:subtotal).sum
  end
end
