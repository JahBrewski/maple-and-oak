class AddMoneyColumnsToProfiles < ActiveRecord::Migration
  def change
    add_money :profiles, :assets_liquid, amount: { null: true, default: nil }
  end
end
