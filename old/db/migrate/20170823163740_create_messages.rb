class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :title, limit: 255
      t.string :text

      t.string :entity_type
      t.integer :entity_id

      t.timestamps
    end
  end
end
