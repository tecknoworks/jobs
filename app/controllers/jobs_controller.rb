class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def create
    pp params[:job]
    @job = Job.create!(title: params[:job][:title], description: params[:job][:description])
  end

end
