class CreateFamiliaritiesProfilesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :familiarities, :profiles do |t|
      # t.index [:familiarity_id, :profile_id]
      # t.index [:profile_id, :familiarity_id]
    end
  end
end
