class AddLiquidAssetsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :assets_liquid, :string
  end
end
