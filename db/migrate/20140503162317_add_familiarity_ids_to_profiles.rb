class AddFamiliarityIdsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :familiarity_ids, :string
  end
end
