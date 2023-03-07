FactoryBot.define do
  factory :race do
    date { DateTime.now }
    place { Faker::Address.country }
  end
end
