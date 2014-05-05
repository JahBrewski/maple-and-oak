class RemoveUnnecessaryStateBooleansFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :approved, :boolean
    remove_column :profiles, :submitted, :boolean
  end
end
