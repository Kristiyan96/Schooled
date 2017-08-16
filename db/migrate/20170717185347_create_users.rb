class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.references :school, foreign_key: true, index: true
      t.references :group,  foreign_key: true, index: true
      t.references :parent, index: true

      t.integer :role,  default: 0,     null: false
      t.boolean :admin, default: false, null: false

      t.string :name,                   null: false
      t.string :email,                  null: false
      t.string :password_digest,        null: false
      t.string :address
      t.string :phone_number

      t.timestamps
    end
  end
end
