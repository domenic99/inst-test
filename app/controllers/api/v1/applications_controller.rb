class Api::V1::ApplicationsController < ApplicationController
  def index
    applications = Application.joins(:job).merge(Job.active)
    render json: applications
  end
end
