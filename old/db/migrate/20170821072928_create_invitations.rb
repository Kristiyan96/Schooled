class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.references :user
      t.references :group

      t.string :identification
      t.string :address
      t.string :phone_number

      t.timestamps
    end
  end
end
