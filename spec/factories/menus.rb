FactoryBot.define do
  factory :menu do
    sequence(:menu_name) { |n| "menu#{n}" }
    sequence(:color) { |n| "color#{n}" }

    trait :no_name do
      menu_name {}
    end

    trait :too_long_name do
      menu_name {Faker::Lorem.characters(number: 11)}
    end

    trait :no_color do
      color {}
    end
  end
end
