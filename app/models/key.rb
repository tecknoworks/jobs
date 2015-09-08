class Key < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  before_create :set_keys

  private

  def set_keys
    self.consumer_key = SecureRandom.urlsafe_base64(20)
    self.secret_key = SecureRandom.urlsafe_base64(20)
  end
end
