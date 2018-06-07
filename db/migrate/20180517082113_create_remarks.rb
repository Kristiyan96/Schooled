class CreateRemarks < ActiveRecord::Migration[5.2]
  def change
    create_table :remarks do |t|
      t.text :message
      t.references :course, foreign_key: true, index: true
      t.integer :student_id, index: true

      t.timestamps
    end
  end
end
