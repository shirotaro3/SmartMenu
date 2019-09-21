FactoryBot.define do
  factory :menu_item do
    sequence(:item_name) { |n| "item#{n}" }
    sequence(:price) { |n| n+400 }

    trait :no_name do
      item_name {}
    end

    trait :too_long_name do
      item_name {Faker::Lorem.characters(number: 11)}
    end

    trait :create_with_text do
      item_text {|n| "text#{n}"}
    end

    trait :create_with_image do
      item_image {Refile::FileDouble.new("dummy", "logo.png", content_type: "image/png")}
    end
  end
end
