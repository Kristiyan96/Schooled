class Homework < ApplicationRecord
  belongs_to :group
  belongs_to :course
  belongs_to :teacher, foreign_key: "teacher_id", class_name: "User"
end
