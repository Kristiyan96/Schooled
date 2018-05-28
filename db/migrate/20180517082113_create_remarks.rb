class CreateRemarks < ActiveRecord::Migration[5.2]
  def change
    create_table :remarks do |t|
      t.text :message
      t.references :course, foreign_key: true
      t.integer :student_id

      t.timestamps
    end
  end
end
