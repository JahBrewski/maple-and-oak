class AddProfileIdsToFamiliarities < ActiveRecord::Migration
  def change
    add_column :familiarities, :profile_ids, :string
  end
end
