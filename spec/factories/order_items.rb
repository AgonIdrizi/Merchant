FactoryGirl.define do
  factory :order_item do
    association :product
    association :cart
    quantity 1
  end
end
