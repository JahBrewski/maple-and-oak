class AddFieldsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :address, :string
    add_column :profiles, :investment_amount, :string
    add_column :profiles, :partner_type, :string
    add_column :profiles, :business_experience, :string
    add_column :profiles, :previous_restaurant_status, :string
    add_column :profiles, :investment_type, :string
  end
end
