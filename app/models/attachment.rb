class Attachment < ActiveRecord::Base

  belongs_to :job

  mount_uploader :file

  validates :job_id, presence: true
  validates :status, presence: true
  validates :file, presence: true

end
