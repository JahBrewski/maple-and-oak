class AddStateAndCityToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :state, :string
    add_column :projects, :city, :string
  end
end
