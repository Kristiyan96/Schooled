class CreateTimeSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :time_slots do |t|
      t.datetime :start
      t.datetime :end
      t.string :title

      t.references :school_year, foreign_key: true, index: true

      t.timestamps
    end
  end
end
