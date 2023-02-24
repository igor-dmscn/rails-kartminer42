FactoryBot.define do
  factory :racer do
    sequence :id
    name { Faker::Name.name }
    born_at { (Racer::MIN_AGE + 1).years.ago }

    trait :with_image do
      image_url { Faker::Internet.url }
    end

    trait :under_min_age do
      born_at { (Racer::MIN_AGE - 1).years.ago }
    end
  end
end
