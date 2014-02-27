class Rename < ActiveRecord::Migration
  def change
    rename_table('projects', 'profiles')
  end
end
