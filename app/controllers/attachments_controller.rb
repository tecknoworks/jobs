class AttachmentsController < ApplicationController
  api :GET, '/attachments', 'Return all attachments'
  def index
    @attachments = Attachment.where(
      'created_at >= :days and candidate_id == :candidate_id',
      days: Time.zone.now - 30.days,
      candidate_id: params[:candidate_id]
    )
  end

  api :GET, '/attachments/:id', 'Return attachment by id'
  def show
    @attachment = Attachment.find(params[:id])
  end

  api :post, '/attachments/:id', 'Create an attachment'
  def create
    @attachment = Attachment.create!(user_id: params[:user_id], candidate_id: params[:candidate_id], file: params[:attachment])
    # unless @attachment.save
    # return render json: @attachment.errors, status: :unprocessable_entity
    # end
  end

  api :put, '/attachments/:id', 'Update an attachment'
  def update
    @attachment = Attachment.find(params[:id])
    @attachment.update_attributes!(user_id: params[:user_id], candidate_id: params[:candidate_id], file: params[:attachment])
  end

  api :delete, 'attachments/:id', 'Detele an attachment'
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.delete
  end

  private

  def attachment_params
    para = params.require(:attachment).permit(:user_id, :candidate_id, :file)
  end
end
