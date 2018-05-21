class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :email, unique: true, null: false
      t.string :password_digest, null: false
      t.string :phone_number

      t.timestamps
    end
  end
end
