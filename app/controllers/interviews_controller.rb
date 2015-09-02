class InterviewsController < ApplicationController
  api :GET, '/api/jobs/:id/candidates/:id/interviews', 'Return list of interviews'
  def index
    @interviews = Interview.where(candidate_id: params[:candidate_id])
  end
end
