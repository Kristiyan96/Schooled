class MessageSenderJob < ApplicationJob
  def perform(sender:, args:)
    Message.send_multiple(sender, args)
  end
end
