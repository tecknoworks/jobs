class JobsController < ApplicationController
  api :GET, '/jobs', 'Return all jobs'
  def index
    # CODE: magic value
    @jobs = Job.where(status: 1)
  end

  api :GET, '/jobs/:id', 'Return one job by id'
  def show
    # CODE: magic value
    @job = Job.where(id: params[:id], status: 1).first
  end
end
