FactoryGirl.define do

  sequence(:email) {|n| "user.#{n}@domain.com" }

  factory :user do
    name "First name Last Name"
    email
    password User::DEFAULT_PASSWORD
  end
end
