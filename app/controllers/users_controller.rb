class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :owner_or_investor_only, only: :show

  def show
    @user = User.find(params[:id])

    @project = @user.project
    @subscription = @user.subscription
    @plan = @user.plan || nil

    render @user.user_type

  end
end
