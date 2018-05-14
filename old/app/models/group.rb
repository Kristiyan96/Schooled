class Group < ApplicationRecord
  belongs_to :school
  belongs_to :hr_teacher, class_name: "User", foreign_key: "user_id"

  has_many :courses
  has_many :students, class_name: "User"
  has_many :messages, as: :entity
  has_many :invitations
  has_many :lessons
end
