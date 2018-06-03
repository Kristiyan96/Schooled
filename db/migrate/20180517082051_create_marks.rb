class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.decimal :grade, null: false
      t.text :note
      t.integer :kind, default: 0, null: false


      t.integer :student_id
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
