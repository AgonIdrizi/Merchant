FactoryGirl.define do
  factory :user do
  	first_name 'Agon'
  	last_name 'Idrizi'
    sequence(:email) {|n| "agon#{n}@agon.com"}
    password "123456"
  end
end
