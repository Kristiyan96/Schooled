class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.references :school

      t.string :name, null: false

      t.timestamps
    end
  end
end
