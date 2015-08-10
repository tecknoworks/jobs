class Attachment < ActiveRecord::Base
  belongs_to :job

  mount_uploader :file
  mount_uploader :file, FileUploader

  validates :job, presence: true
  validates :status, presence: true
  validates :file, presence: true

  PENDING = 0
  FAIL = 1
  PASS = 2
end
