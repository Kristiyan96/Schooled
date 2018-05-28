class Group < ApplicationRecord
	belongs_to :school
	belongs_to :teacher, foreign_key: "teacher_id", class_name: "User"
end
