class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text, null: false

      t.references :recepient, polymorphic: true, index: true
      t.references :sender, polymorphic: true, index: true

      t.timestamps
    end
  end
end
