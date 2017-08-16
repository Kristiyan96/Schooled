class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.references :school,  foreign_key: true, index: true, null: false
      t.references :subject, foreign_key: true, index: true, null: false

      t.date :year, null: false
    end
  end
end
