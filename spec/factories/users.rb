FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "agon#{n}@agon.com"}
    password "123456"
  end
end
