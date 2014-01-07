require 'spec_helper'

describe Subscription do

  let(:user) { FactoryGirl.create(:user) }
  let(:plan) { Plan.where(:plan_type => user.user_type).sample } 

  #its(:plan_id)                 { should validate :presence }
  #its(:stripe_customer_token)   { should validate :presence }
  #its(:user_id)                 { should validate :presence }
  #its(:user_id)                 { should validate :uniqueness }

  describe "credit card info" do
    
    before do
      card = { number: '4242424242424242', exp_month: '11', exp_year: '2020' }

      @subscription = FactoryGirl.create :subscription, user: user, plan: plan, stripe_card_token: card
      @subscription.save_with_payment

      @customer     = Stripe::Customer.retrieve @subscription.stripe_card_token
      @active_card  = @customer.active_card
    end
  end

  describe "subscription creation"

  describe "with valid information"

  describe "with invalid information"

  end

end
