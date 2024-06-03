class Api::V1::JobsController < ApplicationController
  def index
    jobs = Job.all
    render json: jobs
  end
end
