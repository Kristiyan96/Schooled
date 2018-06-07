class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.references :group, foreign_key: true, index: true
      t.references :subject, foreign_key: true, index: true
      t.references :school, foreign_key: true, index: true
      t.references :school_year, foreign_key: true, index: true
      t.integer :teacher_id

      t.timestamps
    end
  end
end
