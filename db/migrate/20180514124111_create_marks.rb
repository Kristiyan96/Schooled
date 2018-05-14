class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.references :student
      t.references :subject
      t.references :school_year

      t.integer :number, null: false

      t.timestamps
    end
  end
end
