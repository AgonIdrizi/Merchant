FactoryGirl.define do
  factory :order do
    user_id user
    status "Unsubmitted"
  end
end
