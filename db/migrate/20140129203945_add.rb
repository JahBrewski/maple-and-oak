class Add < ActiveRecord::Migration
  def change
    add_column :plans, :user_conversation_limit, :integer
  end
end
