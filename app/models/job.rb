class Job < ActiveRecord::Base
  DRAFT = 0
  PUBLISHED = 1
  FILLED = 2
  EXPIRED = 3

  has_many :attachments

  before_save :set_title

  validates :description, presence: true
  validates :status, presence: true

  private

  def set_title
    data = description.split("\n")
    self.title = data[0].gsub(/[^0-9a-z \-\_]/i, '').strip.lstrip
  end
end
