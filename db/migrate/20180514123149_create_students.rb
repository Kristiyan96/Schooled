class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.references :school, null: false
      t.references :parent, null: true

      t.timestamps
    end
  end
end
