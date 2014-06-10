class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if @user.persisted?
      UserMailer.welcome(@user).deliver
    end
  end

  protected


  def after_sign_up_path_for(resource)
    signup_path
  end

  def after_inactive_sign_up_path_for(resource)
    signup_path
  end
end
