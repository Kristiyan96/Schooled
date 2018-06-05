class Absence < ApplicationRecord
  belongs_to :school_year
  belongs_to :student, foreign_key: "student_id", class_name: "User"

  attribute :value, :rational
  enum kind: [:first_semester, :second_semester, :final]
  enum category: [:permanent, :excused]
end
