class UsersController < ApplicationController
  def login
    user = authenticate(params[:email], params[:password])
    unless user.nil?
      @key = Key.create!(user_id: user.id)
    else
      render_response('User not exist', 400_000)
    end
  end

  def logout
  end

  private

  def authenticate(email, _password)
    User.where(email: email).first
    # user = User.where(:username => username).first
    # if user && user.encrypted_password == BCrypt::Engine.hash_secret(password, user.encrypted_password)
    # user
    # else
    # nil
    # end
  end
end
