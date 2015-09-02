class CandidatesController < ApplicationController
  api :GET, '/api/jobs/:id/candidates', 'Return list of candidates'
  def index
    @candidates = Candidate.where(job_id: params[:job_id])
  end

  api :GET, '/api/jobs/:id/candidates/:id', 'Return candidate by id'
  def show
    @candidate = Candidate.find(params[:id])
  end

  api :POST, '/api/jobs/:id/candidates', 'Create an candidate'
  def create
    @candidate = Candidate.create!(candidate_params)
  end

  api :DELETE, '/api/jobs/:id/candidates/:id', 'Delete an candidate'
  def destroy
    @candidate = Candidate.find(params[:id])
    @candidate.delete
  end

  private

  def candidate_params
    para = params.require(:candidate).permit(:full_name, :phone_number, :email)
    para[:job_id] = params[:job_id]
    para
  end
end
