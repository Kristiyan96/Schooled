class Mark < ApplicationRecord
	belongs_to :course
	belongs_to :student, foreign_key: "student_id", class_name: "User"
end
