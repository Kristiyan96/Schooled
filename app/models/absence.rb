class Absence < ApplicationRecord
  belongs_to :course
  belongs_to :student, foreign_key: "student_id", class_name: "User"

  attribute :value, :rational
  enum kind: [:first_semester, :first_semester_total, :second_semester, :second_semester_total]
end
