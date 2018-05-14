class CreateRemarks < ActiveRecord::Migration[5.2]
  def change
    create_table :remarks do |t|
      t.references :student
      t.references :school_year

      t.string :text, null: false

      t.timestamps
    end
  end
end
