class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  TOKEN = "f1dBnPf6f9Kxs9_BYxRC"

  def after_sign_in_path_for(resource)
    activity_logs_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/page", :alert => exception.message
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :last_name, :image,:email, :password, :password_confirmation, :current_password) }
  end

  def authenticate_api
    authenticate_or_request_with_http_token do |token, options|
        ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
    end
  end

end
