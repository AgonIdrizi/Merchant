class Product < ApplicationRecord
  monetize :price_in_cents, as: "price"

  has_many :order_items, dependent: :destroy

  validates :title, presence: true
  validates :price, presence: true,  numericality: { greater_than: 0.00, less_than: 1000000.00 }
  has_one_attached :image
  
end
