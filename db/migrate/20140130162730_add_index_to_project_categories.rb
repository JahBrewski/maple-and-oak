class AddIndexToProjectCategories < ActiveRecord::Migration
  def change
    add_index :project_categories,     :key_name
    add_index :project_sub_categories, :key_name
  end
end
