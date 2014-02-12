class Project < ActiveRecord::Base
  REQUIRED_FIELDS_FOR_PUBLISHING = ["state", "city", "company_name", "email_address",
                     "phone_number", "description", "category", "sub_category"]

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
    contains_required_fields? && approved?
  end

  private

  def contains_required_fields?
    ready = true
    REQUIRED_FIELDS_FOR_PUBLISHING.each do |field|
      if self.query_attribute(field) == false
        errors.add(:base, "#{field} cannot be blank")
        ready = false
      end
    end
    ready
  end

  def approved?
     self.status == "approved"
  end
end
