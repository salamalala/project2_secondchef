class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: "You can't access this page"
  end

  before_filter :store_location

  def store_location
    if current_user.nil? && request.fullpath != new_user_session_path
      puts "HELLO: #{request.fullpath}"
      session[:user_return_to] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
   session[:user_return_to] || request.referrer || root_path
  end
end
