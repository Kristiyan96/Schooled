# frozen_string_literal: true

class Schools::HeadmasterInvitationsController < ApplicationController
  def index
    @school = School.find(params[:school_id])
  end

  def create
    school = School.find(params[:school_id])
    role = Role.find_by(name: 'Headmaster')
    is_invited = Assignment.invite(role: role, school: school, user: user_params)

    if is_invited
      redirect_to school_headmaster_invitations_path(school), notice: 'Invited!'
    else
      redirect_to school_headmaster_invitations_path(school), alert: 'Failed to invite!'
    end
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name)
  end
end
