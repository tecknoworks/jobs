# The main purpose of this module is to overwrite the create method in
# ActiveAdmin::Devise::SessionsController, to perform LDAP based authentication.
#
# == Behaviour
#
# Once a login request is initiated perform Ldap based authentication.
# If the login is succesfull and a user entry for the coresponding credentials
# does not exist in the database, create one.
#
module TkwAuth
  extend ActiveSupport::Concern

  included do
    def create
      self.resource = ldap_auth(auth_options)
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end

    private

    def ldap_auth(auth_options)
      if Ldap.new.valid?(sign_in_params)
        user = User.find_by_email(sign_in_params[:email])
        if user.present?
          pass = sign_in_params[:password]
          user.update(password: pass, password_confirmation: pass)
        else
          User.create!(sign_in_params)
        end
      end
      warden.authenticate!(auth_options)
    end

    def auth_params_present?
      params[:user].present? && params[:user][:email].present? && params[:user][:password].present?
    end
  end
end
