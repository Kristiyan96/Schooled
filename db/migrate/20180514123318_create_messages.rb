class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text, null: false

      t.boolean :read, default: false, null: false
      t.references :sender, polymorphic: true, index: true
      t.references :recipient, polymorphic: true, index: true

      t.timestamps
    end
  end
end
