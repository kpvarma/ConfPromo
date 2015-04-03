FactoryGirl.define do
  factory :user do
    name "Krishnaprasad"
    email "kpvarma@yopmail.com"
    password User::DEFAULT_PASSWORD
  end
end
