class Schools::TeacherInvitationsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @school = School.find(params[:school_id])
    @teachers = @school.teachers
  end

  def create
    @school = School.find(params[:school_id])
    role = Role.find_by(name: "Teacher")
    is_invited = Assignment.invite(role: role, school: @school, user: user_params)
    @teachers = @school.teachers
    
    respond_to do |format|
      if is_invited
        format.html { }
        format.js   { }
      else
        format.html { }
        format.js   { }
      end
    end
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name)
  end
end
