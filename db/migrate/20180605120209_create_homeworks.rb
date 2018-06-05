class CreateHomeworks < ActiveRecord::Migration[5.2]
  def change
    create_table :homeworks do |t|
      t.string :title
      t.date :deadline
      t.text :description
      t.integer :teacher_id
      t.references :group, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
