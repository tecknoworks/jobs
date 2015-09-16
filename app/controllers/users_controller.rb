class UsersController < ApplicationController
  def logged
    key = Key.find(params[:id])
    if key.present?
      if key.consumer_key == params[:consumer_key] && key.secret_key == params[:secret_key]
        @key = key
      else
        render_response('User is not logged', 400_001)
      end
    end
  end

  def login
    user = ldap_auth(params[:user])
    if user.present?
      @key = Key.create!(user_id: user.id)
    else
      render_response('User not exist', 400_000)
    end
  end

  def logout
    @key = Key.find(params[:id])
    if @key.present?
      if @key.consumer_key == params[:consumer_key] && @key.secret_key == params[:secret_key]
        @key.delete
      end
    end
  end

  private

  def ldap_auth(user_params)
    if Ldap.new.valid?(email: user_params[:email], password: user_params[:password])
      user = User.find_by_email(user_params[:email])
      if user.present?
        pass = SecureRandom.urlsafe_base64(20)
        user.update(password: pass, password_confirmation: pass)
        return user
      else
        user = User.create!(email: user_params[:email], password: user_params[:password])
        return user
      end
    end
  end
end
