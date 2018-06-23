class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.references :school, foreign_key: true, index: true

      t.string :name, null: false
      t.string :abbreviation

      t.timestamps
    end
  end
end
