class Job < ActiveRecord::Base
  has_many :candidates

  before_save :set_title

  validates :description, presence: true
  validates :status, presence: true

  DRAFT = 0
  PUBLISHED = 1
  FILLED = 2
  EXPIRED = 3

  private

  def set_title
    data = description.split("\n")
    self.title = data[0].strip
  end
end
