class ParentshipController < ApplicationController
  def create
    is_invited = Parentship.invite_parent(student: current_user, parent: user_params)

    if is_invited
      redirect_back fallback_location: home_path, notice: "Invited!"
    else
      redirect_back fallback_location: home_path, alert: "Failed to invite!"
    end
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name)
  end
end
