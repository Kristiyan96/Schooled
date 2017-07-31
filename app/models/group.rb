class Group < ApplicationRecord
  belongs_to :school

  has_many :course_groups
  has_many :courses, through: :course_groups
  has_many :students, class_name: 'User'
end
