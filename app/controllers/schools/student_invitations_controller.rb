class Schools::StudentInvitationsController < ApplicationController
  def index
    @school = School.find(params[:school_id])
  end

  def create
    school = School.find(params[:school_id])
    group = Group.find(params[:group_id])
    role = Role.find_by(name: "Student")
    is_invited = Assignment.invite(role: role, school: school, user: user_params.merge(group_id: group.id))

    if is_invited
      redirect_to school_group_path(school, group), notice: "Invited!"
    else
      redirect_to school_group_path(school, group), alert: "Failed to invite!"
    end
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name, :number_in_class)
  end
end
