class AddYearsAttendedCulinarySchoolToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :user_culinary_school_years_attended, :string
  end
end
