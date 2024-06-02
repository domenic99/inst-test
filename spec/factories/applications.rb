FactoryBot.define do
  factory :application do
    candidate_name { Faker::Name.name }
    association :job
  end
end
