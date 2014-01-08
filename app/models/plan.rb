class Plan < ActiveRecord::Base
  has_many :subscriptions

  def name
    plan_type.capitalize + " " + plan_level.capitalize
  end

end
