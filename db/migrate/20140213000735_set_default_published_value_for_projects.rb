class SetDefaultPublishedValueForProjects < ActiveRecord::Migration
  def change
    change_column_default :projects, :published, false
  end
end
