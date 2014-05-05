class AddRestaurantOwnerStatusColumnsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :user_current_restaurant_owner, :boolean
    add_column :profiles, :user_previous_restaurant_owner, :boolean
  end
end
