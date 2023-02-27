FactoryBot.define do
  factory :tournament do
    name { Faker::Esport.event }
  end
end
