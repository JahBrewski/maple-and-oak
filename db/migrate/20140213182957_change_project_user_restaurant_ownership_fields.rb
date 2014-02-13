class ChangeProjectUserRestaurantOwnershipFields < ActiveRecord::Migration
  def change
    rename_column :projects, :user_current_restaurant_owner?, :user_current_restaurant_owner
    rename_column :projects, :user_previous_restaurant_owner?, :user_previous_restaurant_owner
  end
end
