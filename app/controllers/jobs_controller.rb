class JobsController < ApplicationController
  api :GET, '/jobs', 'Return all jobs'
  def index
    @jobs = Job.all
  end

  api :GET, '/jobs/:id', 'Return one job by id'
  def show
    @job = Job.find(params[:id])
  end
end
