class Product < ApplicationRecord
  has_many :order_items, dependent: :destroy

  validates :title, presence: true
  validates :price, presence: true,  numericality: { greater_than: 0.00, less_than: 1000000.00 }
  has_one_attached :image
  
end
