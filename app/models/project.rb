class Project < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true 
  validate :project_count_within_limit, :on => :create
  validates :title,
            :city,
            :state,
            :contact_name,
            :email_address,
            :phone_number,
            :description,
            :category,
            :sub_category,
            :presence => true

  mount_uploader :business_plan, BusinessPlanUploader

  def project_count_within_limit
    if self.user.projects.count >= self.user.subscription.plan.user_project_limit
      errors.add(:base, "You can only create #{self.user.subscription.plan.user_project_limit} project(s) with your current plan.")
    end
  end

  def location_state_city
    city.capitalize + ", " + state
  end
end
