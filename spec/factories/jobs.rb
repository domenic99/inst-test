FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Job.key_skill }
  end
end
