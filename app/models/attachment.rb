class Attachment < ActiveRecord::Base
  PENDING = 0
  FAIL = 1
  PASS = 2

  belongs_to :job

  # mount_uploader :file
  # mount_uploader :file, FileUploader

  validates :job, presence: true
  validates :status, presence: true
  validates :file, presence: true
end
