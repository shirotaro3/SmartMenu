FactoryBot.define do
  factory :deleted_shop do
    sequence(:shop_name) { |n| "shopname#{n}" }
    state { 1 }
    sequence(:city) { |n| "city#{n}" }
    sequence(:street) { |n| "street#{n}" }
    postal_code { Faker::Number.number(digits:7).to_s }
    # 先頭が0の数字10桁
    phone_number { Faker::Number.leading_zero_number(digits:10).to_s }
    email { Faker::Internet.email }
  end
end
