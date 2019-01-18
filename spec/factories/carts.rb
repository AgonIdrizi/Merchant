FactoryGirl.define do
  factory :cart do

    trait :with_order_items do
      after(:create) {|cart| create_list(:order_item, 5, cart: cart)}
    end
  end
end
