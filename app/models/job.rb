class Job < ApplicationRecord
  DEFAULT_JOB_STATUS = :deactivated
  STATUS_MAPPING = {
    'Job::Event::Activate' => :activated,
    'Job::Event::Deactivated' => :deactivated
  }.freeze

  has_many :applications, dependent: :destroy
  has_many :job_events, class_name: 'Job::Event',  dependent: :destroy

  def self.active
    joins(:job_events)
      .where(job_events: { id: Job::Event.select('MAX(job_events.id) as id')
                                         .group(:job_id), type: 'Job::Event::Activate' })
  end

  def status
    STATUS_MAPPING[job_events.last&.type] || DEFAULT_JOB_STATUS
  end
end
