class CreateAbsences < ActiveRecord::Migration[5.2]
  def change
    create_table :absences do |t|
      t.string :value, null: false, default: "1/1"
      t.integer :kind, default: 0, null: false
      t.integer :category, default: 0, null: false
      t.integer :student_id
      t.references :school_year, null: false

      t.timestamps
    end
  end
end
