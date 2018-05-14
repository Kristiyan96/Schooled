class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.references :students
      t.references :subject
      t.references :school_year

      t.timestamps
    end
  end
end
