FactoryGirl.define do
  factory :user do
    sequence(:display_name) { |n| "user#{n}" }
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end
end
