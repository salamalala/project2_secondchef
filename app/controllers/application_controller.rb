class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: "You can't access this page"
  end

  before_filter :store_location

  def store_location
    # we only store session[:user_return_to] if the path contains orders/new
    if current_user.nil? && request.fullpath != new_user_session_path  && params[:controller] == "meals"
      puts "HELLO: #{request.fullpath}"
      session[:user_return_to] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
   session[:user_return_to] || request.referrer || root_path
  end

  before_filter :configure_devise_params, if: :devise_controller?
   def configure_devise_params
     devise_parameter_sanitizer.for(:sign_up) do |u|
       u.permit(:first_name, :last_name, :email, :password, :password_confirmation)
     end
   end
end
