class JobsController < ApplicationController
  # CODE: document api
  def index
    @jobs = Job.all
  end

  # CODE: document api
  def show
    @job = Job.find(params[:id])
  end

  # CODE: document api
  def create
    # CODE:
    # use strong params
    # what if error?
    @job = Job.create!(title: params[:job][:title], description: params[:job][:description])
  end
end
