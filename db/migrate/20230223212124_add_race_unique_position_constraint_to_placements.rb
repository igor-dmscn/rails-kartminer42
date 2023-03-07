class AddRaceUniquePositionConstraintToPlacements < ActiveRecord::Migration[7.0]
  def change
    add_index :placements, [:race_id, :position], unique: true
  end
end
