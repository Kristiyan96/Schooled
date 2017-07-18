class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
    	t.references :subject,        index: true
    	t.references :school,         index: true
      t.date :year
    end
  end
end
