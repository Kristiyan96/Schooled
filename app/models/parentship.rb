class Parentship < ApplicationRecord
  belongs_to :student, foreign_key: "student_id", class_name: "User"
  belongs_to :parent,  foreign_key: "parent_id",  class_name: "User"

  def self.invite_parent(student, parent)
    parent = User.find_by(email: parent[:email]) || User.invite!(parent)
    create(parent: parent, student: student)
  end
end
