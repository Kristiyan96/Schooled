class CreateRemarks < ActiveRecord::Migration[5.2]
  def change
    create_table :remarks do |t|
      t.references :students
      t.references :school_year

      t.timestamps
    end
  end
end
