class Group < ApplicationRecord
  belongs_to :school
  belongs_to :teacher, foreign_key: "teacher_id", class_name: "User"

  has_many :students, class_name: "User"
  has_many :courses
  has_many :homeworks
  has_many :schedules, through: :courses

  scope :for_assignment, -> assignment {
    joins(:courses)
      .where(courses: {school_id: assignment.school_id, 
                       teacher_id: assignment.user_id}).distinct
  }
end
