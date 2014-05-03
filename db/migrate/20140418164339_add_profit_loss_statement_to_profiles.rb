class AddProfitLossStatementToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profit_loss_statement, :string
  end
end
