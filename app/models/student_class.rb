class StudentClass < ApplicationRecord
  belongs_to :course
  belongs_to :group
  belongs_to :teacher, class_name: 'User', foreign_key: 'user_id'

  has_many :students, through: :group
  has_many :subjects, through: :course
end
