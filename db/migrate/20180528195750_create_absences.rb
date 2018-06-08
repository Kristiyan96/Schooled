class CreateAbsences < ActiveRecord::Migration[5.2]
  def change
    create_table :absences do |t|
      t.string :value, null: false, default: "0/1"
      t.integer :kind, default: 0, null: false
      t.integer :category, default: 0, null: false
      t.integer :student_id, index: true

      t.references :school_year, foreign_key: true, index: true
      t.references :schedule, foreign_key: true, index: true

      t.timestamps
    end
  end
end
