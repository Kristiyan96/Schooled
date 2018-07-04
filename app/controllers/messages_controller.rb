# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    #TODO: Fix this shit
    skip_policy_scope
    @name = MessageHash.for(current_user)
  end

  private

  def message_params
    params.require(:messages).permit(:text, :user_id, :school_id, :group_id, message_type: [])
  end
end
