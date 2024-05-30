class Job < ApplicationRecord
  has_many :applications, dependent: :destroy
  has_many :job_events, class_name: 'Job::Event',  dependent: :destroy
end
