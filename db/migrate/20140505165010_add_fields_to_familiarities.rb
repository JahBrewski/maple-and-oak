class AddFieldsToFamiliarities < ActiveRecord::Migration
  def change
    rename_column :familiarities, :name, :key_name
    add_column :familiarities, :description, :string
  end
end
