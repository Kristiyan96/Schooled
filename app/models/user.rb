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
  has_many :homeworks
  has_many :courses

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

  def is_headmaster?(school)
    assignments.where(role_id: 3, school: school).any?
  end

  def is_headteacher?(group)
    group.teacher == self
  end

  def is_teacher?(school)
    assignments.where(school: school, role_id: 2).any?
  end

  def is_teacher_of_group?(group)
    group.courses.where(teacher: self).any?
  end

  def is_teaching_course?(course)
    course.teacher == self
  end

  def is_student?(school)
    group.school == school
  end

  def is_student_in_group?(group)
    self.group == group
  end

  def is_parent_in_group?(group)
    students.where(group: group).any?
  end

  def is_parent_of?(student)
    Parentship.where(parent: self, student: student).any?
  end
end
