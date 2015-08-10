class Candidate < ActiveRecord::Base
  belongs_to :job
  has_many :attachments

  validates :full_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :job, presence: true

end
