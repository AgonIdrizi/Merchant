FactoryGirl.define do
  factory :order_item do
    association :product
    association :order
    quantity 1
  end
end
