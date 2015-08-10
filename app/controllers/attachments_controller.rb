class AttachmentsController < ApplicationController
  api :GET, '/attachments', 'Return all attachments'
  def index
    @attachments = Attachment.where(
      'created_at >= :days and job_id == :job_id',
      days: Time.now - 30.days,
      job_id: params[:job_id]
    )
  end

  api :GET, '/attachments/:id', 'Return attachment by id'
  def show
    @attachment = Attachment.find(params[:id])
  end
end
