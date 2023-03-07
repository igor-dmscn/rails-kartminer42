class AddRaceAndUserRefToPlacements < ActiveRecord::Migration[7.0]
  def change
    add_reference :placements, :race, null: false, foreign_key: true
    add_reference :placements, :racer, null: false, foreign_key: true
  end
end
