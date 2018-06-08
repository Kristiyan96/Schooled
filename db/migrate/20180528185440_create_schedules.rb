class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :course, foreign_key: true, index: true
      t.references :time_slot, foreign_key: true, index: true

      t.timestamps
    end
  end
end
