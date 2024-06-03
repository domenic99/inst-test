class Application::Event < ApplicationRecord
  belongs_to :application

  scope :status_affecting, -> { where.not(type: 'Application::Event::Note') }
end
