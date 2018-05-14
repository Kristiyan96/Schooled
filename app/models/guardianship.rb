class Guardianship < ApplicationRecord
  belongs_to :child, class_name: "Student", foreign_key: "student_id"
  belongs_to :parent
end
