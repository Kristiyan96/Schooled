module UsersHelper
  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end

  def role_summary(user)
    if user.assignments.any?
      assignment = user.assignments.order(:created_at).first
      school     = assignment.school
      case assignment.role.name
      when "Headmaster"
        role = "Директор"
      when "Teacher"
        role = Учител
      when "Student"
        role = "Ученик"
      end
    end

    if user.students.any?
      role = "Родител"
    end
      "#{role} в <a href='#{school_url(school)}'>#{school.name}</a>"
  end

  def user_url(user)
    profile_path(user.id)
  end

  def can_add_parent?(user, student)
    student && student.assignments.any? && 
    student.assignments.order(:created_at).first.role.name == "Student" &&
    (student.in?(user.students) ||    #user is parent
     student.group.teacher == user || #user is head_teacher
     student == user)                 #user is the student
  end
end