class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, to: :crud

    if user.present?

      # Absence
      can :read, Absence do |absence|
        group = absence.student.group
        absence.student == user ||
          is_parent_of?(user, absence.student) ||
          is_headmaster?(user, group.school)
      end

      can :crud, Absence do |absence|
        is_teaching_course?(user, absence.schedule.course) ||
          is_headteacher?(user, absence.schedule.course.school)
      end 

      # Assignment
      can :crud, Assignment, do |assignment|
        is_headmaster?(user, assignment.school)
      end 

      # Course
      can :read, Course do |course|
        is_student_in_group?(user, course.group) ||
          is_parent_in_group?(user, course.group) ||
          is_teaching_course?(user, course) ||
      end

      can :crud, Schedule do |schedule|
        is_headmaster?(user, course.school) ||
          is_headteacher?(user, course.group)
      end 

      # Group
      can :read, Group do |group|
        is_student_in_group?(user, group) ||
          is_teacher?(user, group.school) ||
          is_headmaster?(user, group.school) ||
          is_parent_in_group?(user, group)
      end
      can :create, Group do |group|
        is_headmaster?(user, group.school) || is_teacher?(user, group.school)
      end
      can :update, Group do |group|
        is_headteacher?(user, group) || is_headmaster?(user, group.school)
      end

      # Homework
      can :read, Homework do |homework|
        group = homework.group
        is_student_in_group?(user, group) || 
          is_parent_in_group?(user, group) ||
          is_headmaster?(user, group.school) ||
          is_teacher_of_group?(user, group)
      end

      can :crud, Homework do |homework|
        is_teaching_course?(user, homework.course)
      end

      # Mark
      can :read, Mark do |mark|
        group = mark.student.group
        mark.student == user ||
          is_parent_of?(user, mark.student) ||
          is_headmaster?(user, group.school)
      end

      can :crud, Mark do |mark|
        is_teaching_course?(user, mark.course) ||
          is_headteacher?(user, mark.course.group)
      end  

      # Message

      # Parentship
      can :create, Parentship do |parnetship|
        parentship.student == user ||
          is_parent_of?(user, parentship.student) ||
          is_headteacher?(user, parentship.student.group)
      end

      can :crud, Prentship do |parentship|
        is_headteacher?(parentship.student.group)
      end 

      # Remark
      can :read, Remark do |remark|
        group = remark.student.group
        remark.student == user ||
          is_parent_of?(user, remark.student) ||
          is_headteacher?(user, group) ||
          is_headmaster?(user, group.school)
      end

      can :crud, Remark do |remark|
        is_teaching_course?(user, remark.course)
      end  

      # Role
      # No one, just the seeds

      # Schedule
      can :read, Schedule do |schedule|
        group = schedule.course.group
        is_headmaster?(user, group.school) ||
          is_teaching_course?(user, schedule.course) ||
          is_parent_in_group?(user, group) ||
          is_student_in_group?(user, group)
      end

      can :crud, Schedule do |schedule|
        is_headteacher?(user, schedule.group)
      end  

      # School
      can :read, School
      can :update, School do |school|
        is_headmaster?(user, school)
      end

      # School Year
      can :crud, SchoolYear do |sc_year|
        is_headmaster?(user, sc_year.school)
      end  

      # Subject
      can :crud, Subject do |subject|
        is_headmaster?(user, subject.school)
      end 

      # Time Slot
      can :crud, TimeSlot do |time_slot|
        is_headmaster?(user, time_slot.school)
      end 

      # User
      can :crud, User do |us|
        is_headmaster?(user, us.group.school) ||
          is_headteacher?(user, us.group)
      end 

      if user.admin?
        can :manage, :all
      end
    end
  end

  def is_headmaster?(user, school)
    school.assignments.where(user: user, role_id: 3).any?
  end

  def is_headteacher?(user, group)
    group.teacher == user
  end

  def is_teacher?(user, school)
    school.assignments.where(user: user, role_id: 2).any?
  end

  def is_teacher_of_group?(user, group)
    user.courses.where(group: group)
  end

  def is_teaching_course?(user, course)
    course.teacher == user
  end

  def is_student?(user, school)
    user.group.school == school
  end

  def is_student_in_group?(user, group)
    user.group == group
  end

  def is_parent_in_group?(user, group)
    user.students.where(group: group)
  end

  def is_parent_of?(parent, student)
    Parentship.find_by(parent_id: parent.id, student_id: student.id).any?
  end
end
