class MessagesController < ApplicationController
  def create
    # Message type is an array of [:user, :group_students, :group_parents, :teachers, :all_students, :all_parents]
    MessageSenderJob.perform_later(sender: current_user, args: message_params)
  end

  private

  def message_params
    params.require(:messages).permit(:text, :user_id, :school_id, :group_id, message_type: [])
  end
end
