FactoryBot.define do
  factory :application_event, class: 'Application::Event' do
    association :application
    type do
      %w[Application::Event::Hire Application::Event::Interview
         Application::Event::Note Application::Event::Reject].sample
    end

    factory :application_event_hire, class: 'Application::Event::Hire' do
      hire_date { Date.today }
      type { 'Application::Event::Hire' }
    end

    factory :application_event_interview, class: 'Application::Event::Interview' do
      interview_date { Date.today }
      type { 'Application::Event::Interview' }
    end

    factory :application_event_note, class: 'Application::Event::Note' do
      content { Faker::Lorem.sentence }
      type { 'Application::Event::Note' }
    end

    factory :application_event_reject, class: 'Application::Event::Reject' do
      type { 'Application::Event::Reject' }
    end
  end
end
