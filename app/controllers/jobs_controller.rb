class JobsController < ApplicationController
  api :GET, '/jobs', 'Return all jobs'
  def index
    if logged(params)
      @jobs = Job.all
    else
      render_response('You are not logged', 400_001)
    end
  end

  api :GET, '/jobs/:id', 'Return one job by id'
  def show
    if logged(params)
      @job = Job.find(params[:id])
    else
      render_response('You are not logged', 400_001)
    end
  end

  api :POST, '/jobs', 'Create an job'
  def create
    if logged(params)
      @job = Job.create!(job_params)
    else
      render_response('You are not logged', 400_001)
    end
  end

  api :DELETE, '/jobs/:id', 'Delete an job'
  def destroy
    if logged(params)
      @job = Job.find(params[:id])
      @job.delete
    else
      render_response('You are not logged', 400_001)
    end
  end

  api :PATCH, '/job/:id', 'Update an job'
  def update
    if logged(params)
      @job = Job.find(params[:id])
      @job.update_attributes!(job_params)
    else
      render_response('You are not logged', 400_001)
    end
  end

  private

  def job_params
    params.require(:job).permit(:status, :description)
  end
end
