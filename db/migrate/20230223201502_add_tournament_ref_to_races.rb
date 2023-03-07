class AddTournamentRefToRaces < ActiveRecord::Migration[7.0]
  def change
    add_reference :races, :tournament, null: false, foreign_key: true
  end
end
