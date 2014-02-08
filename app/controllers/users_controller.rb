class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
    @project = current_user.project
    @subscription = current_user.subscription
    @plan = current_user.plan || nil

    render current_user.user_type

  end
end
