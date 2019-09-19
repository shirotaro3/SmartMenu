FactoryBot.define do
  factory :shop do
    sequence(:shop_name) { |n| "shopname#{n}" }
    state { 1 }
    sequence(:city) { |n| "city#{n}" }
    sequence(:street) { |n| "street#{n}" }
    postal_code { "3332222" }
    phone_number { "0120444444" }
    password { "password" }
    sequence(:email) { |n| "aaa#{n}@aaa.com" }

    trait :no_name do
      shop_name {}
    end

    trait :too_long_name do
      shop_name {Faker::Lorem.characters(number: 16)}
    end

    trait :too_short_name do
      shop_name {Faker::Lorem.characters(number: 1)}
    end

    trait :no_state do
      state {}
    end

    trait :no_city do
      city {}
    end

    trait :too_long_city do
      city {Faker::Lorem.characters(number: 9)}
    end

    trait :no_street do
      street {}
    end

    trait :too_long_street do
      street {Faker::Lorem.characters(number: 41)}
    end

    trait :too_short_street do
      street {Faker::Lorem.characters(number: 5)}
    end

    trait :no_postal_code do
      postal_code {}
    end

    trait :no_phone_number do
      phone_number {}
    end
  end
end
