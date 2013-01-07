FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end
  sequence :name do |n|
    "Example User #{n}"
  end
  factory :user do
    name     FactoryGirl.generate :name
    email    FactoryGirl.generate :email
    password "foobar"
    password_confirmation "foobar"
  end
end
