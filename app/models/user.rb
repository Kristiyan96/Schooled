class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :marks
  has_many :groups
  has_many :assignments
  has_many :roles, through: :assignments
  has_many :parentships
  has_many :parents, through: :parentships
  has_many :students, through: :parentships

  belongs_to :group, optional: true

  def role?(role, school)
  	assignments.any? { |a| a.school == school && a.role.name.underscore.to_sym == role }
  end
end
