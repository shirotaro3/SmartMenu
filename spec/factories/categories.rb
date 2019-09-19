FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "name#{n}" }

    trait :no_name do
      name {}
    end

    trait :too_long_name do
      name {Faker::Lorem.characters(number: 11)}
    end
  end
end
