class CandidatesController < ApplicationController
  api :GET, '/api/jobs/:id/candidates', 'Return list of candidates'
  def index
    if logged(params) == true
      @candidates = Candidate.where(job_id: params[:job_id])
    end
  end

  api :GET, '/api/jobs/:id/candidates/:id', 'Return candidate by id'
  def show
    if logged(params) == true
      @candidate = Candidate.find(params[:id])
    end
  end

  api :POST, '/api/jobs/:id/candidates', 'Create an candidate'
  def create
    if logged(params) == true
      @candidate = Candidate.create!(candidate_params)
    end
  end

  api :DELETE, '/api/jobs/:id/candidates/:id', 'Delete an candidate'
  def destroy
    if logged(params) == true
      @candidate = Candidate.find(params[:id])
      @candidate.delete
    end
  end

  api :UPDATE, 'api/jobs/:id/candidates/:id', 'Update an candidate'
  def update
    if logged(params) == true
      @candidate = Candidate.find(params[:id])
      @candidate.update_attributes!(candidate_params)
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:full_name, :phone_number, :email, :job_id, :source)
  end
end
