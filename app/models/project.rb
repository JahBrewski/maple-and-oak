class Project < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true 
  validates :company_name,
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
  mount_uploader :company_image, CompanyImageUploader

  def location_state_city
    city.capitalize + ", " + state
  end

  def category_and_sub_category
    self.category.gsub("_"," ") + " | " + self.sub_category.gsub("_"," ")
  end

end
