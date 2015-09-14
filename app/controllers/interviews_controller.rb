class InterviewsController < ApplicationController
  api :GET, '/api/jobs/:id/candidates/:id/interviews', 'Return list of interviews'
  def index
    if logged(params) == true
      @interviews = Interview.where(candidate_id: params[:candidate_id])
    end
  end

  api :GET, '/api/jobs/:id/candidates/:id/interviews/:id', 'Return an interview'
  def show
    if logged(params) == true
      @interview = Interview.find(params[:id])
    end
  end

  api :POST, '/api/jobs/:id/candidates/:id/interviews', 'Create an interview'
  def create
    if logged(params) == true
      key = Key.where(consumer_key: params[:consumer_key], secret_key: params[:secret_key]).first
      create_params = interview_params
      create_params['user_id'] = key['user_id']

      @interview = Interview.where(user_id: create_params[:user_id], candidate_id: create_params[:candidate_id]).first
      if @interview.nil?
        @interview = Interview.create!(create_params)
      else
        @interview.update_attributes!(create_params)
      end
    end
  end

  api :DELETE, '/api/jobs/:id/candidates/:id/interviews/:id', 'Delete an interview'
  def destroy
    if logged(params) == true
      key = Key.where(consumer_key: params[:consumer_key], secret_key: params[:secret_key]).first

      @interview = Interview.find(params[:id])
      if @interview['user_id'] == key.user_id
        @interview.delete
      else
        render_response('Permission denied', 400_002)
      end
    end
  end

  private

  def interview_params
    params.require(:interview).permit(:candidate_id, :date_and_time)
  end
end
