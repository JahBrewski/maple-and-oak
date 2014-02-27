class RenameCategories < ActiveRecord::Migration
  def change
    rename_table('project_categories','profile_categories')
    rename_table('project_sub_categories','profile_sub_categories')
  end
end
