class Comment < ActiveRecord::Base
  belongs_to :interview
  belongs_to :user

  validates :body, presence: true
  validates :user, presence: true
  validates :interview, presence: true
end
