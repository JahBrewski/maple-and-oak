class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
    @project_limit = 0

    if current_user.subscription
      @project_limit = current_user.plan.user_project_limit
    end

    @projects = current_user.projects
  end
end
