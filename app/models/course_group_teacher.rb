class CourseGroupTeacher < ApplicationRecord
  belongs_to :course_group
  belongs_to :teacher, class_name: 'User'
end
