class Plan < ActiveRecord::Base
  has_many :subscriptions
  validates :plan_type, presence: true
  validates :plan_level, presence: true
  validates :user_profile_limit, presence: true
  validates :user_conversation_limit, presence: true
  validates :price, presence: true

  def name
    plan_type.capitalize + " " + plan_level.capitalize
  end

end
