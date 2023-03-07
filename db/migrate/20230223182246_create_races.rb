class CreateRaces < ActiveRecord::Migration[7.0]
  def change
    create_table :races do |t|
      t.datetime :date
      t.string :place

      t.timestamps
    end
  end
end
