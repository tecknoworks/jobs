class JobsController < ApplicationController
  api :GET, '/jobs', 'Return all jobs'
  def index
    @jobs = Job.where(status: Job::PUBLISHED)
  end

  api :GET, '/jobs/:id', 'Return one job by id'
  def show
    @job = Job.where(id: params[:id], status: Job::PUBLISHED).first
  end
end
