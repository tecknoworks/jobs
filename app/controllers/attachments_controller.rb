class AttachmentsController < ApplicationController
  api :GET, '/attachments', 'Return all attachments'
  def index
    @attachments = Attachment.where(
      'created_at >= :days and job_id == :job_id',
      :days  => Time.now - 30.days,
      :job_id => params[:job_id]
    ).all
  end

  api :GET, '/attachments/:id', 'Return attachment by id'
  def show
    begin
      @attachment = Attachment.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render_response(e.message, 400_001)
    end
  end
end
