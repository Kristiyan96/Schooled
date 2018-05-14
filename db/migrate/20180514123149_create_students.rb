class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.references :school, null: false
      t.references :parent, null: true

      t.string :email, unique: true, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
