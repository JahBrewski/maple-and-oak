class RemoveUserConversationLimitFromPlans < ActiveRecord::Migration
  def change
    remove_column :plans, :user_conversation_limit
  end
end
