FactoryBot.define do
  factory :application_event, class: 'Application::Event' do
    association :application

    factory :application_event_hire, class: 'Application::Event::Hire' do
      hire_date { Date.today }
    end

    factory :application_event_interview, class: 'Application::Event::Interview' do
      interview_date { Date.today }
    end

    factory :application_event_note, class: 'Application::Event::Note' do
      content { Faker::Lorem.sentence }
    end

    factory :application_event_reject, class: 'Application::Event::Reject'
  end
end
