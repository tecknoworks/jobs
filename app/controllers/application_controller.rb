class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session                 # modification

  def render_response(body, code = 200)
    body = {
      code: code,
      body: body
    }

    render json: body, status: code
  end

  def logged(params)
    Key.where(consumer_key: params[:consumer_key], secret_key: params[:secret_key]) != []
  end
end
