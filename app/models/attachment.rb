class Attachment < ActiveRecord::Base
  PENDING = 0
  FAIL = 1
  PASS = 2

  belongs_to :candidate
  belongs_to :user

  # mount_uploader :file, FileUploader

  validates :user, presence: true
  validates :candidate, presence: true
  validates :file, presence: true
end
