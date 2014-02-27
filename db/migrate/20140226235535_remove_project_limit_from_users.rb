class RemoveProjectLimitFromUsers < ActiveRecord::Migration
  def change
    remove_column :plans, :user_project_limit
  end
end
