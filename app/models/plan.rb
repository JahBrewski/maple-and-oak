class Plan < ActiveRecord::Base
  has_many :subscriptions
  validates :plan_type, presence: true
  validates :plan_level, presence: true
  validates :price, presence: true

  def name
    plan_type.capitalize + " " + plan_level.capitalize
  end

end
