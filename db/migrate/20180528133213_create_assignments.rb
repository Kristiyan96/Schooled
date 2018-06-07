class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.references :role, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.references :school, foreign_key: true, index: true

      t.timestamps
    end
  end
end
