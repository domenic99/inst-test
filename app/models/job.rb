class Job < ApplicationRecord
  has_many :applications, dependent: :destroy
  has_many :job_events, class_name: 'Job::Event',  dependent: :destroy

  def self.active
    joins(:job_events)
      .where(job_events: { id: Job::Event.select('MAX(job_events.id) as id')
                                         .group(:job_id), type: 'Job::Event::Activate' })
  end
end
