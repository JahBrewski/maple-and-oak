class PlansController < ApplicationController

  before_filter :authenticate_user!

  def signup
    @plan = Plan.where(:plan_type => current_user.user_type.to_s).where(:plan_level => "bronze")
    @plan = @plan[0]
    @subscription = Subscription.new
  end
end

