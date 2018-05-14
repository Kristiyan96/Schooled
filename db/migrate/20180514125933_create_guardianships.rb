class CreateGuardianships < ActiveRecord::Migration[5.2]
  def change
    create_table :guardianships do |t|
      t.references :parents
      t.references :students

      t.timestamps
    end
  end
end
