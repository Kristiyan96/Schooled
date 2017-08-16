class CreateStudentClass < ActiveRecord::Migration[5.1]
  def change
    create_table :student_classes do |t|
      t.references :course, foreign_key: true, index: true, null: false
      t.references :group,  foreign_key: true, index: true, null: false
      t.references :user,   foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
