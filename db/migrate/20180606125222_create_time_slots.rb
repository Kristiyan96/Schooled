class CreateTimeSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :time_slots do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
