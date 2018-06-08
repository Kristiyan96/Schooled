class Mark < ApplicationRecord
  belongs_to :course
  belongs_to :student, foreign_key: "student_id", class_name: "User"

  enum kind: [:first_semester, :first_semester_final, :second_semester, :second_semester_final, :final]
  validates_uniqueness_of :kind, if: :first_semester_final?, scope: [:student_id, :course]
  validates_uniqueness_of :kind, if: :second_semester_final?, scope: [:student_id, :course]
  validates_uniqueness_of :kind, if: :final?, scope: [:student_id, :course]
end
