class ChangeProjectTitleToCompanyName < ActiveRecord::Migration
  def change
    rename_column :projects, :title, :company_name
  end
end
