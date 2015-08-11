class CandidatesController < ApplicationController
  api :GET, '/candidates', 'Return list of candidates'
  def index
    @candidates = Candidate.where(job_id: params[:job_id])
  end

  api :GET, '/candidates/:id', 'Return candidate by id'
  def show
    @candidate = Candidate.find(params[:id])
  end
end
