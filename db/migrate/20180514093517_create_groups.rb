class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :teacher_id
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
