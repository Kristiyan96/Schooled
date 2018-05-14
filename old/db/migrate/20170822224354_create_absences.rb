class CreateAbsences < ActiveRecord::Migration[5.1]
  def change
    create_table :absences do |t|
      t.references :user,           index: true
      t.references :course,         index: true
      t.decimal :excused,           null: false, default: 0.0
      t.decimal :permanent,         null: false, default: 0.0
      t.integer :purpose,           null: false, default: 0

      t.timestamps
    end
  end
end
