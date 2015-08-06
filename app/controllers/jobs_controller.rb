class JobsController < ApplicationController
  api :GET, '/jobs', 'Return all jobs'
  def index
    @jobs = Job.all
  end

  api :GET, '/jobs/:id', 'Return one job by id'
  def show
    begin
      @job = Job.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render_response(e.message, 400_001)
    end
  end
end
