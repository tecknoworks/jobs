class Interview < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :user
  has_many :comments

  validates :candidate, presence: true
  validates :user, presence: true
  validates :date_and_time, presence: true
end
