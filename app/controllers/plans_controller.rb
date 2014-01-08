class PlansController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user_type = current_user.user_type.to_s
    @plans = Plan.where(:plan_type => @user_type)
    @plan_type = @user_type
  end

  def show
    @plan         = Plan.find params[:plan]
    @subscription = Subscription.new
  end
end

