class Subscription < ActiveRecord::Base

  attr_accessor :stripe_card_token

  belongs_to :plan
  belongs_to :user

  validates :plan_id,               presence: true
  validates :user_id,               presence: true, uniqueness: true
  validates :stripe_customer_token, presence: true
end
