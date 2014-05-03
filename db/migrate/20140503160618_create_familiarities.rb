class CreateFamiliarities < ActiveRecord::Migration
  def change
    create_table :familiarities do |t|
      t.string :name

      t.timestamps
    end
  end
end
