class UpdateProjectFields < ActiveRecord::Migration
  def change
    rename_column :projects, :email_address, :contact_email_address
    rename_column :projects, :phone_number, :contact_phone_number
    rename_column :projects, :description, :short_description
    add_column :projects, :long_description, :string
    add_column :projects, :user_hospitality_experience, :string
    add_column :projects, :user_management_experience, :string
    add_column :projects, :user_current_position, :string
    add_column :projects, :user_highest_position, :string
    add_column :projects, :user_current_restaurant_owner?, :string
    add_column :projects, :user_previous_restaurant_owner?, :string
  end
end
