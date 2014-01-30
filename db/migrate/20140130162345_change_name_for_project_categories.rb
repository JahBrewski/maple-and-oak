class ChangeNameForProjectCategories < ActiveRecord::Migration
  def change
    rename_column :project_categories, :name, :key_name
    rename_column :project_sub_categories, :name, :key_name
  end
end
