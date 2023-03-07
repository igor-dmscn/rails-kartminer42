FactoryBot.define do
  factory :racer do
    name { Faker::Name.name }
    born_at { (Racer::MIN_AGE + 1).years.ago }

    trait :without_name do
      name { nil }
    end

    trait :without_born_at do
      born_at { nil }
    end

    trait :with_invalid_born_at do
      born_at { 1 }
    end

    trait :with_id do
      sequence(:id)
    end

    trait :with_image_url do
      image_url { Faker::Internet.url }
    end

    trait :with_invalid_image_url do
      image_url { Faker::File.file_name }
    end

    trait :under_min_age do
      born_at { (Racer::MIN_AGE - 1).years.ago }
    end
  end
end
