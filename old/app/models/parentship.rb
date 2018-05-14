class Parentship < ApplicationRecord
  belongs_to :student, foreign_key: "student_id", class_name: "User"
  belongs_to :parent,  foreign_key: "parent_id",  class_name: "User"
end
