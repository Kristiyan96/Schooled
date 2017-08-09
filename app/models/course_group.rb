class CourseGroup < ApplicationRecord
  belongs_to :course
  belongs_to :group

  has_many :course_group_teachers
  has_many :teachers, through: :course_group_teachers, source: :user
end
