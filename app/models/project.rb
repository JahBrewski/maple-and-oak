class Project < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true 
  validate :project_count_within_limit, :on => :create

  def project_count_within_limit
    #if self.user.projects(:reload).count >= self.user.subscription.plan.user_project_limit
    #  errors.add(:base, "You can only create #{self.user.subscription.plan.user_project_limit} project(s) with your current plan.")
    #end
  end
end
