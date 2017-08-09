class CourseGroupTeacher < ApplicationRecord
  belongs_to :course_group
  belongs_to :user
end
