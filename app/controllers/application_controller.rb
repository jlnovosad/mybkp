class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :phone, :email, :password, :password_confirmation, :remember_me, :tender, :privateprofile, :bio, :location_id) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :phone, :email, :password, :remember_me, :tender, :privateprofile, :bio, :location_id) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :phone, :email, :password, :password_confirmation, :current_password, :tender, :privateprofile, :bio, :location_id) }
  end
end
