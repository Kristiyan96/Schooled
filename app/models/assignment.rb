class Assignment < ApplicationRecord
  belongs_to :role
  belongs_to :user
  belongs_to :school

  def self.invite(school:, role:, user:)
    user = User.find_by(email: user[:email]) || User.invite!(user)
    create(school: school, role: role, user: user)
  end

  def name
    "#{role.name} at #{school.name}"
  end
end
