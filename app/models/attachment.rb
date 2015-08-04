class Attachment < ActiveRecord::Base

  belongs_to :job

  validates :job_id, presence: true
  validates :status, presence: true
  validates :file, presence: true

end
