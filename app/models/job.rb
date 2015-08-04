class Job < ActiveRecord::Base

  has_many :attachments

  validates :title, presence: true
  validates :description, presence: true

end
