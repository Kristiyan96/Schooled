class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :assignments
  has_many :roles, thourgh: :assignments

  def role?(role, school)
  	assignments.any? { |a| a.school == school && a.role.name.underscore.to_sym == role }
  end
end
