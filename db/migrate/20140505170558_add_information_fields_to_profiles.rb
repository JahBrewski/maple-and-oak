class AddInformationFieldsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :user_serv_safe_certified, :boolean
    add_column :profiles, :user_has_criminal_record, :boolean
    add_column :profiles, :user_criminal_record_explanation, :string
    add_column :profiles, :user_attended_culinary_school, :boolean
    add_column :profiles, :user_culinary_school_name, :string
    add_column :profiles, :user_graduated_culinary_school, :boolean
    add_column :profiles, :user_professional_awards, :string
    
    remove_column :profiles, :user_current_restaurant_owner
    remove_column :profiles, :user_previous_restaurant_owner
  end
end
