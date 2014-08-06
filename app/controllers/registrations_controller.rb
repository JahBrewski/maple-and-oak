class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if @user.persisted?
      UserMailer.welcome(@user).deliver
      AdminMailer.user_created(@user).deliver
    end
  end

  def destroy
    @user = current_user
    AdminMailer.user_destroyed(@user).deliver
    if @user.subscription
      customer = Stripe::Customer.retrieve(@user.subscription.stripe_customer_token)
      customer.delete
    end
    super
  end

  protected


  def after_sign_up_path_for(resource)
    signup_path
  end

  def after_inactive_sign_up_path_for(resource)
    signup_path
  end
end
