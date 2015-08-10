class Candidate < ActiveRecord::Base
  belongs_to :job

  validates :full_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :job_id, presence: true

end
