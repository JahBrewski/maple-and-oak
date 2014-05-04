class AddStatusFieldsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :submitted, :boolean, :default => false
    add_column :profiles, :approved, :boolean, :default => false
  end
end
