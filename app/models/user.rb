class User < ActiveRecord::Base
  has_many :attachments
  has_many :interviews
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
