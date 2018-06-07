class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text, null: false

      t.integer :sender_id, null: false, index: true
      t.integer :recepient_id, null: false, index: true

      t.timestamps
    end
  end
end
