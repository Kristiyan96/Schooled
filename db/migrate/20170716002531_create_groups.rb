class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.references :school, foreign_key: true, index: true, null: false

      t.integer :grade, null: false
      t.string :name,   null: false

      t.timestamps
    end
  end
end
