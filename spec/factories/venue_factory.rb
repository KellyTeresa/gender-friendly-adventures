require 'faker'
FactoryGirl.define do
  factory :venue do
    name { Faker::Company.name }
    street_address { Faker::Address.street_address }
    city "Boston"
    state "MA"
    zip_code "02144"
    summary "This is a nice place to hang out."

    trait :has_description do
      description "Good food. Friendly staff. All bathrooms are gender neutral."
    end

    trait :has_website do
      website { Faker::Internet.url }
    end

    trait :has_phone do
      phone_number { Faker::PhoneNumber.phone_number }
    end
  end
end
