class JobsController < ApplicationController
  api :GET, '/jobs', 'Return all jobs'
  def index
    @jobs = Job.where(status: Job::PUBLISHED)
  end

  api :GET, '/jobs/:id', 'Return one job by id'
  def show
    @job = Job.find(params[:id])
  end

  api :POST, '/jobs', 'Create an job'
  def create
    @job = Job.create!(job_params)
  end

  api :DELETE, '/jobs/:id', 'Delete an job'
  def destroy
    @job = Job.find(params[:id])
    @job.delete
  end

  api :PATCH, '/job/:id', 'Update an job'
  def update
    @job = Job.find(params[:id])
    @job.update_attributes!(job_params)
  end

  private

  def job_params
    params.require(:job).permit(:status, :description)
  end
end
