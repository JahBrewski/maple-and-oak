class AddConversationsInitiatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :conversations_initiated, :integer
  end
end
