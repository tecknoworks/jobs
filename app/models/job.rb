class Job < ActiveRecord::Base
  DRAFT = 0
  PUBLISHED = 1
  FILLED = 2
  EXPIRED = 3
  DASHBOARD = 4

  has_many :attachments

  before_save :set_title

  validates :description, presence: true
  validates :status, presence: true

  # Each instance of the application has a job with status DASHBOARD created
  # from the seed.
  #
  # ==== Returns
  #
  # * +:String:+ - the description of the job or ''
  #
  def self.dashboard_description
    Job.where(status: DASHBOARD).try(:first).try(:description) || ''
  end

  private

  def set_title
    data = description.split("\n")
    self.title = data[0].gsub(/[^0-9a-z \-\_\.\,]/i, '').strip.lstrip
  end
end
