class RemoveAssetsLiquidAttributeFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :assets_liquid, :string
  end
end
