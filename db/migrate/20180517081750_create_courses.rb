class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.references :group, foreign_key: true
      t.references :subject, foreign_key: true
      t.references :school, foreign_key: true
      t.references :school_year, foreign_key: true

      t.timestamps
    end
  end
end
