class ChangeDefaultForInitiatedConversations < ActiveRecord::Migration
  def change
    change_column :users, :conversations_initiated, :integer, :default => 0
  end
end
