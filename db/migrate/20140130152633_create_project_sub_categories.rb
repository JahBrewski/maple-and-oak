class CreateProjectSubCategories < ActiveRecord::Migration
  def change
    create_table :project_sub_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
