FactoryGirl.define do
  factory :order do
    user_id user
    status "Unsubmitted"
    association :shipping_address, factory: :address
  end
end
