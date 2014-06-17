class AddStripeFieldsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_four, :string
    add_column :subscriptions, :card_type, :string
    add_column :subscriptions, :card_expiration, :string
    add_column :subscriptions, :next_bill_on, :date
  end
end
