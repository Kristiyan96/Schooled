class CreateClassrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :classrooms do |t|
      t.references :teacher
      t.references :subject
      t.references :school_year

      t.timestamps
    end
  end
end
