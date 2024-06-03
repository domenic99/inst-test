class Application < ApplicationRecord
  DEFAULT_APPLICATION_STATUS = :applied
  STATUS_MAPPING = {
    'Application::Event::Interview' => :interview,
    'Application::Event::Hire' => :hired,
    'Application::Event::Reject' => :rejected,
  }.freeze

  belongs_to :job
  has_many :application_events, class_name: 'Application::Event', dependent: :destroy

  def status
    status_event = application_events.where.not(type: 'Application::Event::Note').last

    STATUS_MAPPING[status_event&.type] || DEFAULT_APPLICATION_STATUS
  end
end
