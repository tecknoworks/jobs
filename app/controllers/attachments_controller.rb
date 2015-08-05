class AttachmentsController < ApplicationController
  api :GET, '/attachments', 'Return all jobs'
  def index
    @attachments = Attachment.where(job_id: params[:job_id]).all
  end

  api :GET, '/attachments/:id', 'Return all jobs'
  def show
    @attachment = Attachment.find(params[:id])
  end
end
