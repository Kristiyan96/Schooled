class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :course
      t.references :time_slot

      t.timestamps
    end
  end
end
