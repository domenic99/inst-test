FactoryBot.define do
  factory :job_event, class: 'Job::Event' do
    association :job
    type { %w[Job::Event::Activate Job::Event::Deactivate].sample }

    factory :job_event_activate, class: 'Job::Event::Activate' do
      type { 'Job::Event::Activate' }
    end

    factory :job_event_deactivate, class: 'Job::Event::Deactivate' do
      type { 'Job::Event::Deactivate' }
    end
  end
end
