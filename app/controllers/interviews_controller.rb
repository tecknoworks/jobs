class InterviewsController < ApplicationController
  api :GET, '/api/jobs/:id/candidates/:id/interviews', 'Return list of interviews'
  def index
    @interviews = Interview.where(candidate_id: params[:candidate_id])
  end

  api :GET, '/api/jobs/:id/candidates/:id/interviews/:id', 'Return an interview'
  def show
    @interview = Interview.find(params[:id])
  end

  api :POST, '/api/jobs/:id/candidates/:id/interviews', 'Create an interview'
  def create
    @interview = Interview.create!(interview_params)
  end

  private

  def interview_params
    para = params.require(:interview).permit(:user_id, :status)
    para[:candidate_id] = params[:candidate_id]
    para
  end
end
