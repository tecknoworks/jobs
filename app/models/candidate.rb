class Candidate < ActiveRecord::Base
  belongs_to :job
  has_many :attachments

  validates :full_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :job, presence: true

  validate :validate_email_format

  private

  def validate_email_format
    errors.add(:email, 'invalid email format') unless
      ValidateEmail.validate(email)
  end
end
