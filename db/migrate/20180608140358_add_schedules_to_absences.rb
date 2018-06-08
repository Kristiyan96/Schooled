class AddSchedulesToAbsences < ActiveRecord::Migration[5.2]
  def change
    add_reference :absences, :schedules, foreign_key: true
  end
end
