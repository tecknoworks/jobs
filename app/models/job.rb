class Job < ActiveRecord::Base
  has_many :attachments

  before_create :set_title

  validates :description, presence: true

  private

  def set_title
    data = self.description.split("\n")
    self.title = data[0].strip
  end

end
