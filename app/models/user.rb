class User < ActiveRecord::Base
  has_many :attachments
  has_many :interviews

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
