class CreateSlots < ActiveRecord::Migration[5.1]
  def change
    create_table :slots do |t|
      t.references :school, foreign_key: true
      t.integer :start_time
      t.integer :end_time

      t.timestamps
    end
  end
end
