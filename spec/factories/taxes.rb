FactoryBot.define do
  factory :tax do
    rate {1.08}
  end

  trait :no_rate do
    rate {}
  end
end
