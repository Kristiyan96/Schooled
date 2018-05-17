class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
    	t.references :school

      t.string :email, unique: true, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
