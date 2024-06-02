FactoryBot.define do
  factory :job_event, class: 'Job::Event' do
    association :job

    factory :job_event_activate, class: 'Job::Event::Activate'
    factory :job_event_deactivate, class: 'Job::Event::Deactivate'
  end
end
