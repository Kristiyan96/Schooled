class Course < ApplicationRecord
  belongs_to :subject
  belongs_to :school

  has_many :course_users
  has_many :students, through: :course_users, class_name: 'User'
end
