class AttachmentsController < ApplicationController
  api :GET, '/attachments', 'Return all jobs'
  def index
    @attachments = Attachment.where(job_id: params[:job_id]).all
  end

  api :GET, '/attachments/:id', 'Return all jobs'
  def show
    begin
      @attachment = Attachment.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render_response(e.message, 400_001)
    end
  end
end
