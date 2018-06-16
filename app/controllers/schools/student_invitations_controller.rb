class Schools::StudentInvitationsController < ApplicationController
  
  def new
    @school = School.find(params[:school_id])
    @group  = @school.groups.find(params[:group_id])
    @students = policy_scope(@group.students)
    authorize @group, :update?
  end

  def create
    school = School.find(params[:school_id])
    group = Group.find(params[:group_id])
    authorize group, :update?
    role = Role.find_by(name: "Student")
    @is_invited = Assignment.invite(role: role, school: school, user: user_params.merge(group_id: group.id))

    respond_to do |format|
      if @is_invited
        @user = User.find_by(email: user_params[:email])
        format.html { redirect_to school_group_path(school, group), notice: "Invited!" }
        format.js {  }
      else
        format.html {redirect_to school_group_path(school, group), alert: "Failed to invite!"}
        format.js {  }
      end
    end
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name, :number_in_class)
  end
end
