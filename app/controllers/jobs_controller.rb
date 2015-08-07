class JobsController < ApplicationController
  api :GET, '/jobs', 'Return all jobs'
  def index
    @jobs = Job.where(status: 1)
  end

  api :GET, '/jobs/:id', 'Return one job by id'
  def show
    @job = Job.where(id: params[:id], status: 1).first
  end
end
