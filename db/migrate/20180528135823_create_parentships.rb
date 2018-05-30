class CreateParentships < ActiveRecord::Migration[5.2]
  def change
    create_table :parentships do |t|
      t.integer :parent_id
      t.integer :student_id

      t.timestamps
    end

    add_index :parentships, [:parent_id, :student_id], unique: true
  end
end
