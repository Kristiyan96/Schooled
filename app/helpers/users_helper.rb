module UsersHelper
  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end

  def role_summary(user)
    if user.assignments.any?
      assignment = user.assignments.order(:created_at).first
      school     = assignment.school
      "#{assignment.role.name} at <a href='#{school_url(school)}'>#{school.name}</a>"
    elsif user.students.any?
      "Parent"
    end
  end

  def user_url(user)
    profile_path(user.id)
  end
end