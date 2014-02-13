class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authorized_users_and_admin_only(authorized_users)
    authorized_users.each do |authorized_user|
      unless current_user.user_type == authorized_user || current_user.admin == true
        redirect_to current_user
      end
    end
  end

  def authorized_users_and_owner_and_admin_only(authorized_users)
    @owner = User.find(params[:id])
    authorized_users.each do |authorized_user|
      unless current_user == @owner || current_user.user_type == authorized_user || current_user.admin == true
        redirect_to current_user
      end
    end
  end

  def after_sign_in_path_for(user)
    user_path(user)
  end

  def after_sign_up_path_for(user)
    profile_path  
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :remember_me, :user_type) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password) }
  end
end
