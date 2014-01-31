class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
    @projects = current_user.projects 

    @subscription = nil
    @plan = nil
    @project_limit = 0

    if current_user.subscription
      @subscription = current_user.subscription
      @plan = current_user.subscription.plan
      @project_limit = current_user.plan.user_project_limit
    end

  end
end
