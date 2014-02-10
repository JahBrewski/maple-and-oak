class Project < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true 

  mount_uploader :business_plan, BusinessPlanUploader
  mount_uploader :company_image, CompanyImageUploader

  def location_state_city
    city.capitalize + ", " + state
  end

  def category_and_sub_category
    self.category.gsub("_"," ") + " | " + self.sub_category.gsub("_"," ")
  end

  def ready_to_publish?

    ready = true
    required_fields = 
      ["state",
       "city",
       "company_name",
       "email_address",
       "phone_number",
       "description",
       "category",
       "sub_category" ]

    required_fields.each do |field|
      if self.query_attribute(field) == false
        ready = false
        errors.add(:base, "#{field} cannot be blank")
      end
    end

    ready

  end
end
