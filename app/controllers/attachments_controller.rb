class AttachmentsController < ApplicationController
  api :GET, '/attachments', 'Return all attachments'
  def index
    @attachments = Attachment.where(
      'created_at >= :days and job_id == :job_id',
      :days  => Time.now - 30.days,
      :job_id => params[:job_id]
    )
  end

  api :GET, '/attachments/:id', 'Return attachment by id'
  def show
    @attachment = Attachment.find(params[:id])
  end

  def create
    # CODE: test this
    @attachment = Attachment.create(job_id: params[:job_id], status: 0, file: params[:attachment])
    unless @attachment.save
      return render json: @attachment.errors, status: :unprocessable_entity
    end
  end
end
