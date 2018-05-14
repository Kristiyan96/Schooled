class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.references :school,        index: true
      t.references :group,         index: true
      t.integer :role,             default: 0
      t.integer :number
      t.boolean :admin,            default: false
      t.boolean :accepted,         default: false
      t.string :name
      t.string :email,             null: false
      t.string :address
      t.string :password_digest
      t.string :identification
      t.string :phone_number

      t.timestamps
    end
  end
end
