class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :active_subscription?
  before_filter(:only => [:show]) { |c| c.authorized_users_and_owner_and_admin_only ["investor"] } 

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @subscription = @user.subscription
    @plan = @user.plan || nil

    render @user.user_type
  end

end
