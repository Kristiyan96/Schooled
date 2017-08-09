class User < ApplicationRecord
  belongs_to :school,  optional: true
  belongs_to :group,   optional: true

  has_many :marks
  has_many :course_students
  has_many :courses, through: :course_students
  has_many :course_group_teachers
  has_many :course_groups, through: :course_group_teachers

  enum role: { student: 0, teacher: 1, moderator: 2, headmaster: 3 }

  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :password,
            presence: true,
            length: { minimum: 6 }

  def admin?
    admin
  end
end
