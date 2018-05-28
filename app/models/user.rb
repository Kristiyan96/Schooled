class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :invitable

  has_many :marks
  has_many :groups
  has_many :assignments
  has_many :roles, through: :assignments

  has_many :student_relations, foreign_key: "parent_id", class_name: "Parentship"
  has_many :students, through: :student_relations, source: :student
  has_many :parent_relations, foreign_key: "student_id", class_name: "Parentship"
  has_many :parents, through: :parent_relations, source: :parent

  belongs_to :group, optional: true

  def role?(role, school)
    assignments.where(school: school, role: { name: role.to_s.capitalize }).any?
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
