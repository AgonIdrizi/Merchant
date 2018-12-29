FactoryGirl.define do
  factory :address do
    line1 "Gostivarska 26"
    line2 "Just here"
    city "Tetovo"
    state "VA"
    zip "23144"
    association :user
  end
end
