class InvitationsController < ApplicationController
  load_and_authorize_resource
  
  def show
  end

  def new
    @invitation = Invitation.new
  end

  def create
    current_user.invitations.create!(invitation_params)
  end

  def destroy
    @invitation = Invitation.find(params[:id])

    InvitationAccepter.new(@invitation).save! if accept?

    @invitation.destroy!
  end

  private

  def invitation_params
    params.require(:invitation)
          .permit(:group_id, :identification, :phone_number, :address)
          .merge(user_id: current_user.id)
  end

  def accept?
    params.require(:accept)
  end
end
