class CreateMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :marks do |t|
      t.references :course,           index: true
      t.references :user,             index: true
      t.integer :mark,                null: false
      t.integer :purpose,             default: 0
      t.string :description

      t.timestamps
    end
  end
end
