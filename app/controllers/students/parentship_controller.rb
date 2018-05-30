class Students::ParentshipController < ApplicationController
  def create
    student = User.find(params[:student_id])
    is_invited = Parentship.invite_parent(student: student, parent: user_params)

    if is_invited
      redirect_back fallback_location: profile_path(student), notice: "Invited!"
    else
      redirect_back fallback_location: profile_path(student), alert: "Failed to invite!"
    end
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name)
  end
end
