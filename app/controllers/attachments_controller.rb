class AttachmentsController < ApplicationController
  api :GET, '/attachments', 'Return all attachments'
  def index
    if logged(params)
      @attachments = Attachment.where(
        'created_at >= :days and candidate_id == :candidate_id',
        days: Time.zone.now - 30.days,
        candidate_id: params[:candidate_id]
      )
    else
      render_response('You are not logged', 400_001)
    end
  end

  api :GET, '/attachments/:id', 'Return attachment by id'
  def show
    if logged(params)
      @attachment = Attachment.find(params[:id])
    else
      render_response('You are not logged', 400_001)
    end
  end

  api :post, '/attachments/:id', 'Create an attachment'
  def create
    if logged(params)
      @attachment = Attachment.create!(user_id: params[:user_id], candidate_id: params[:candidate_id], file: params[:attachment])
    else
      render_response('You are not logged', 400_001)
    end
    # unless @attachment.save
    # return render json: @attachment.errors, status: :unprocessable_entity
    # end
  end

  api :put, '/attachments/:id', 'Update an attachment'
  def update
    if logged(params)
      @attachment = Attachment.find(params[:id])
      @attachment.update_attributes!(user_id: params[:user_id], candidate_id: params[:candidate_id], file: params[:attachment])
    else
      render_response('You are not logged', 400_001)
    end
  end

  api :delete, 'attachments/:id', 'Detele an attachment'
  def destroy
    if logged(params)
      @attachment = Attachment.find(params[:id])
      @attachment.delete
    else
      render_response('You are not logged', 400_001)
    end
  end

  private

  def attachment_params
    para = params.require(:attachment).permit(:user_id, :candidate_id, :file)
  end

  def logged(params)
    if Key.where(consumer_key: params[:consumer_key], secret_key: params[:secret_key]) == []
      return false
    else
      return true
    end
  end
end
