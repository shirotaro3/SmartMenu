FactoryBot.define do
  factory :shop do
    shop_name { "Macallan" }
    state { 1 }
    city { "加須市" }
    street { "花崎1-1-1" }
    postal_code { "3332222" }
    phone_number { "0120444444" }
    password { "abcd123" }
    email { "aaa@aaa.com" }
  end
end
