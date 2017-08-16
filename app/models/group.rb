class Group < ApplicationRecord
  belongs_to :school

  has_one :student_class
  has_one :course, through: :student_class
  has_many :students, class_name: 'User'
end
