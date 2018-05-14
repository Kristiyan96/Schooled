class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all

    elsif user.moderator?

      can :manage, School, id: user.school_id
      can :manage, [Course, Group, Slot, User], school_id: user.school_id

    elsif user.teacher?

      can :manage, [Group, Course], school_id: user.school_id
      can :manage, Mark do |mark|
        mark.course_id.in?(user.courses.map(&:id)) || mark.course.group_id == user.hr_group.id
      end
      can :manage, Absence do |abs|
        abs.course_id.in?(user.courses.map(&:id)) || abs.course.group_id == user.hr_group.id
      end
      can :manage, [Lesson, User, Invitation], group_id: user.hr_group.id

    elsif user.student?

      can :read, [Absence, Invitation, Mark], user_id: user.id
      can :read, [Course, Lesson, User], group_id: user.group_id
      can :read, Group, id: user.group_id
      can :read, School, id: user.school_id

      can :manage, User, id: user.id
      can :create, Invitation

    else

    end
  end
end
