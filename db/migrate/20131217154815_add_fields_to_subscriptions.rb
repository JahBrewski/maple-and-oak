class AddFieldsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stripe_customer_token, :string
    add_column :subscriptions, :email, :string
  end
end
