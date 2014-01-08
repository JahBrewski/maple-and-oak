class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :price
      t.string :plan_type
      t.string :plan_level
      t.integer :user_project_limit

      t.timestamps
    end
  end
end
