FactoryBot.define do
  factory :shop do
    sequence(:shop_name) { |n| "shopname#{n}" }
    state { 1 }
    sequence(:city) { |n| "city#{n}" }
    sequence(:street) { |n| "street#{n}" }
    postal_code { Faker::Number.number(digits:7).to_s }
    # 先頭が0の数字10桁
    phone_number { Faker::Number.leading_zero_number(digits:10).to_s }
    password { "password" }
    email { Faker::Internet.email }

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

    # 関連を全部作成(無理やり)
    trait :create_with_menus do
      after(:create) do |shop|
        create_list(:menu, 3, shop: shop) do |menu|
          create_list(:category,2, shop: shop) do |category|
            create_list(:item_group,3, menu: menu, category: category) do |item_group|
              create_list(:menu_item,3,item_group: item_group)
            end
          end
        end
      end
    end
  end
end
