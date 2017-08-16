class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :name,         null: false
      t.string :address,      null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
