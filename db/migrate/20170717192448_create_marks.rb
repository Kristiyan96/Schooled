class CreateMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :marks do |t|
      t.references :course, foreign_key: true, index: true, null: false
      t.references :user,   foreign_key: true, index: true, null: false

      t.float :mark,                       null: false
      t.integer :purpose,  default: 0,     null: false
      t.boolean :approved, default: false, null: false

      t.string :description

      t.timestamps
    end
  end
end
