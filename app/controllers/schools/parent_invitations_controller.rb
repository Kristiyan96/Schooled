class ParentshipController < ApplicationController
  def create
    is_invited = Parentship.invite(student: current_user, parent: user_params)

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
