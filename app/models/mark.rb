class Mark < ApplicationRecord
  belongs_to :course
  belongs_to :student, foreign_key: "student_id", class_name: "User"

  enum kind: [:first_semester, :first_semester_final, :second_semester, :second_semester_final]
end
