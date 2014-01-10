class AddFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :contact_name, :string
    add_column :projects, :email_address, :string
    add_column :projects, :phone_number, :string
    add_column :projects, :description, :string
    add_column :projects, :category, :string
    add_column :projects, :sub_category, :string
  end
end
