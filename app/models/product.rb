class Product < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true,  numericality: { greater_than: 0, less_than: 1000000 }
  has_one_attached :image
end
