class JobsController < ApplicationController
  api :GET, '/jobs', 'Return all jobs'
  def index
    if logged(params) == true
      @jobs = Job.all
    end
  end

  api :GET, '/jobs/:id', 'Return one job by id'
  def show
    if logged(params) == true
      @job = Job.find(params[:id])
    end
  end

  api :POST, '/jobs', 'Create an job'
  def create
    if logged(params) == true
      @job = Job.create!(job_params)
    end
  end

  api :DELETE, '/jobs/:id', 'Delete an job'
  def destroy
    if logged(params) == true
      @job = Job.find(params[:id])
      @job.delete
    end
  end

  api :PATCH, '/job/:id', 'Update an job'
  def update
    if logged(params) == true
      @job = Job.find(params[:id])
      @job.update_attributes!(job_params)
    end
  end

  private

  def job_params
    params.require(:job).permit(:status, :description)
  end
end
