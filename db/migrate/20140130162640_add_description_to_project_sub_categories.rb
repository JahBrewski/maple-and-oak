class AddDescriptionToProjectSubCategories < ActiveRecord::Migration
  def change
    add_column :project_sub_categories, :description, :string
  end
end
