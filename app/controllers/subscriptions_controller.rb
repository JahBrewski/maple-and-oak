class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user

    @plan = Plan.find params[:subscription][:plan_id]

    if @subscription.save_with_payment
      flash[:success] = 'Subscription added!'
      redirect_to user_path(current_user)
    else
      flash.now[:error] = 'Unable to add subscription!'
      render template: 'plans/show'
    end
  end

  def edit
    @subscription = Subscription.find(params[:id])
    @plan = @subscription.plan
  end

  def update
    @subscription = Subscription.find(params[:id])
    @plan = @subscription.plan
    
    if @subscription.update_with_payment(subscription_params)
      flash[:success] = 'Card info updated!'
      redirect_to user_path(current_user)
    else
      flash.now[:error] = 'Unable to update card info!'
      redirect_to edit_subscription_path(@subscription)
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  private

  def subscription_params
    params.require(:subscription).permit(:plan_id, :email, :stripe_card_token).merge(user_id: current_user.id)
  end
end
