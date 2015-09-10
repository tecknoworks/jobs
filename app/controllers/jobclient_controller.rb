class JobclientController < ApplicationController
  def index
    @jobs = Job.where(status: Job::PUBLISHED)
  end

  def show
    @job = Job.find(params[:id])
  end
end
