class AddRacerUniquePositionPerRaceConstraintToPlacements < ActiveRecord::Migration[7.0]
  def change
    add_index :placements, [:racer_id, :race_id], unique: true
  end
end
