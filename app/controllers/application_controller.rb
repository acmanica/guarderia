class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    activity_logs_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/page", :alert => exception.message
  end

end
