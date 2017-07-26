class User < ApplicationRecord
  belongs_to :school,  optional: true
  belongs_to :group,   optional: true

  has_many :marks
  has_many :courses, through: :course_students
  has_many :teaching_groups, through: :course_group_teacher, class_name: 'CourseGroup'

  enum role: { student: 0, teacher: 1, moderator: 2, director: 3 }

  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :password,
            presence: true,
            length: { minimum: 6 }

  def admin?
    admin
  end
end
