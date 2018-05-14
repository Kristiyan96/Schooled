class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :name,         null: false
      t.string :abbreviation,  null: false
      t.integer :grade,       null: false

      t.timestamps
    end
  end
end
