class CommentsController < ApplicationController
  def index
    if logged(params) == true
      @comments = Comment.where(interview_id: params[:interview_id])
    end
  end

  def create
    if logged(params) == true
      key = Key.where(consumer_key: params[:consumer_key], secret_key: params[:secret_key]).first
      create_params = comment_params
      create_params['user_id'] = key['user_id']

      @comment = Comment.create!(create_params)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:interview_id, :body)
  end
end
