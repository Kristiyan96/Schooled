class CreateHeadmasters < ActiveRecord::Migration[5.2]
  def change
    create_table :headmasters do |t|
      t.references :school, null: false

      t.timestamps
    end
  end
end
