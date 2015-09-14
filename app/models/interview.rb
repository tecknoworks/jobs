class Interview < ActiveRecord::Base
  FAIL = 0
  PASS = 1

  belongs_to :candidate
  belongs_to :user

  validates :candidate, presence: true
  validates :user, presence: true
  validates :date_and_time, presence: true
  validates :status, presence: true
  validates :status, inclusion: { in: [FAIL, PASS] }
end
