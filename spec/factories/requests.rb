FactoryBot.define do
  factory :request do
    sequence(:title) { |n| "title#{n}" }
    sequence(:message) { |n| "message#{n}" }

    trait :no_title do
      title {}
    end

    trait :too_long_title do
      title {Faker::Lorem.characters(number: 13)}
    end

    trait :no_message do
      message {}
    end

    trait :too_long_message do
      message {Faker::Lorem.characters(number: 201)}
    end
  end
end
