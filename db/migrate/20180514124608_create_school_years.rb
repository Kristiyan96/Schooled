class CreateSchoolYears < ActiveRecord::Migration[5.2]
  def change
    create_table :school_years do |t|
      t.references :school
      t.string :year
      t.boolean :active, default: false, null: false

      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
