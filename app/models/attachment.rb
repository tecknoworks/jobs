class Attachment < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :user

  mount_uploader :file
  mount_uploader :file, FileUploader

  validates :user, presence: true
  validates :status, presence: true
  validates :file, presence: true
  validates :candidate, presence: true

  PENDING = 0
  FAIL = 1
  PASS = 2
end
