class CreateGuardianships < ActiveRecord::Migration[5.2]
  def change
    create_table :guardianships do |t|
      t.references :parent
      t.references :student

      t.timestamps
    end
  end
end
