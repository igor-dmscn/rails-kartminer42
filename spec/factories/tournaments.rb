FactoryBot.define do
  factory :tournament do
    name { Faker::Esport.event }

    trait :with_races do
      races { [association(:race)] }
    end
  end
end
