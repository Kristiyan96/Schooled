class CreateAbsences < ActiveRecord::Migration[5.2]
  def change
    create_table :absences do |t|
      t.decimal :value, null: false
      t.integer :kind, default: 0, null: false

      t.bigint :student_id
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
