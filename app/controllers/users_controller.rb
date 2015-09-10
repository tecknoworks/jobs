class UsersController < ApplicationController
  def login
    user = authenticate(params[:user][:email], params[:user][:password])
    if user.nil?
      render_response('User not exist', 400_000)
    else
      @key = Key.create!(user_id: user.id)
    end
  end

  def logout
  end

  private

  def authenticate(email, _password)
    User.where(email: email).first
  end
end
