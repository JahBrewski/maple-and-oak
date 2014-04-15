class AddMoreMoneyColumnsToProfiles < ActiveRecord::Migration
  def change
    add_money :profiles, :assets_marketable_securities, amount: { null: true, default: nil }
    add_money :profiles, :assets_real_estate, amount: { null: true, default: nil }
    add_money :profiles, :assets_personal, amount: { null: true, default: nil }
    add_money :profiles, :assets_notes_receivable, amount: { null: true, default: nil }
    add_money :profiles, :assets_business_holdings, amount: { null: true, default: nil }
    add_money :profiles, :assets_total, amount: { null: true, default: nil }
    add_money :profiles, :liabilities_notes_payable, amount: { null: true, default: nil }
    add_money :profiles, :liabilities_accounts_payable, amount: { null: true, default: nil }
    add_money :profiles, :liabilities_auto_loans, amount: { null: true, default: nil }
    add_money :profiles, :liabilities_mortgage, amount: { null: true, default: nil }
    add_money :profiles, :liabilities_other, amount: { null: true, default: nil }
    add_money :profiles, :liabilities_total, amount: { null: true, default: nil }
    add_money :profiles, :net_worth, amount: { null: true, default: nil }
  end
end
