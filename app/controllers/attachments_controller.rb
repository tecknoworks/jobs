class AttachmentsController < ApplicationController
  api :GET, '/attachments', 'Return all attachments'
  def index
    if logged(params) == true
      @attachments = Attachment.where(
        'created_at >= :days and candidate_id == :candidate_id',
        days: Time.zone.now - 30.days,
        candidate_id: params[:candidate_id]
      )
    end
  end

  api :GET, '/attachments/:id', 'Return attachment by id'
  def show
    if logged(params) == true
      @attachment = Attachment.find(params[:id])
    end
  end

  api :post, '/attachments/:id', 'Create an attachment'
  def create
    if logged(params) == true
      key = Key.where(consumer_key: params[:consumer_key], secret_key: params[:secret_key]).first
      @attachment = Attachment.create!(user_id: key.user_id, candidate_id: params[:candidate_id], file: params[:file])
    end
  end

  api :delete, 'attachments/:id', 'Detele an attachment'
  def destroy
    if logged(params) == true
      key = Key.where(consumer_key: params[:consumer_key], secret_key: params[:secret_key]).first
      @attachment = Attachment.find(params[:id])
      if @attachment['user_id'] == key.user_id
        @attachment.delete
      else
        render_response('Permission denied', 400_002)
      end
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:candidate_id, :file)
  end
end
