class AddSeatNumberToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :seat_number, :string
  end
end
