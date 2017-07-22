class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.references :school,        index: true
      t.references :group,         index: true
      t.integer :role, default: 0
      t.boolean :admin, default: false
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
