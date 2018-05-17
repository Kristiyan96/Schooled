class Group < ApplicationRecord
  belongs_to :school
  belongs_to :teacher, optional: true
  
  has_many :students
end
