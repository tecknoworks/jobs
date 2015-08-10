class Job < ActiveRecord::Base
  has_many :attachments

  before_save :set_title

  validates :description, presence: true
  validates :status, presence: true

  private

  def set_title
    data = description.split("\n")
    self.title = data[0].strip
  end

end
