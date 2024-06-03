class Application < ApplicationRecord
  DEFAULT_APPLICATION_STATUS = :applied
  STATUS_MAPPING = {
    'Application::Event::Interview' => :interview,
    'Application::Event::Hire' => :hired,
    'Application::Event::Reject' => :rejected,
  }.freeze

  belongs_to :job
  has_many :application_events, class_name: 'Application::Event', dependent: :destroy
  has_many :notes, class_name: 'Application::Event::Note'
  has_many :interviews, class_name: 'Application::Event::Interview'

  def self.hired
    joins(:application_events)
      .where(application_events: { id: Application::Event.select('MAX(application_events.id) as id').status_affecting
                                                         .group(:application_id), type: 'Application::Event::Hire' })
  end

  def self.rejected
    joins(:application_events)
      .where(application_events: { id: Application::Event.select('MAX(application_events.id) as id').status_affecting
                                                         .group(:application_id), type: 'Application::Event::Reject' })
  end

  def self.ongoing
    where.not(id: rejected).where.not(id: hired)
  end

  def status
    status_event = application_events.where.not(type: 'Application::Event::Note').last

    STATUS_MAPPING[status_event&.type] || DEFAULT_APPLICATION_STATUS
  end
end
