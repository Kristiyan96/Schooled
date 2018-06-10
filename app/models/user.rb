class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :invitable

  has_many :sent_messages, as: :sender
  has_many :received_messages, as: :recepient
  has_many :marks
  has_many :absences
  has_many :groups
  has_many :assignments
  has_many :roles, through: :assignments

  has_many :student_relations, foreign_key: "parent_id", class_name: "Parentship"
  has_many :students, through: :student_relations, source: :student
  has_many :parent_relations, foreign_key: "student_id", class_name: "Parentship"
  has_many :parents, through: :parent_relations, source: :parent

  belongs_to :group, optional: true

  def role?(role, school)
    assignments.any? { |a| a.school == school && a.role.name.underscore.to_sym == role }
    # assignments.where(school: school, role: { name: role.to_s.capitalize }).any?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def role_summary
    if assignments.any?
      asgn = assignments.order(:created_at).first
      "#{asgn.role.name} at #{asgn.school.link}"
    elsif students.any?
      "Parent"
    end
  end

  def role_image
    if assignments.any?
      role = assignments.order(:created_at).first.role.name == "Headmaster" ?
        "Teacher" : assignments.order(:created_at).first.role.name
    elsif students.any?
      role = "Parent"
    end
    "roles/#{role}".downcase 
  end

  def student_info
    "#"+"#{number_in_class} #{self.full_name}"
  end
end
