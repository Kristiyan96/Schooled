class Group < ApplicationRecord
  belongs_to :school
  belongs_to :teacher
  
  has_many :students
end
