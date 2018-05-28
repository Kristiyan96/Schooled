class Course < ApplicationRecord
  belongs_to :group
  belongs_to :subject
  belongs_to :school
  belongs_to :school_year
  belongs_to :teacher, foreign_key: "teacher_id", class_name: "User"
end
