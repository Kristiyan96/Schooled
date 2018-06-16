class ParentshipController < ApplicationController
  
  def create
    @user = current_user
    authorize @user
    
    is_invited = Parentship.invite_parent(student: current_user, parent: user_params)

    if is_invited
      redirect_back fallback_location: profile_path(current_user), notice: "Invited!"
    else
      redirect_back fallback_location: profile_path(current_user), alert: "Failed to invite!"
    end
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name)
  end
end
