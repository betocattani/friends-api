# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :invalid_contact do
      first_name { nil }
    end

    trait :friend do
      name { Faker::Name.first_name }
      email { Faker::Internet.email }
      password { Faker::Internet.password }
    end
  end
end
