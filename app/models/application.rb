class Application < ApplicationRecord
  belongs_to :job
  has_many :application_events, class_name: 'Application::Event', dependent: :destroy
end
