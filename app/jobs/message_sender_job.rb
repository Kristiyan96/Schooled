class MessageSenderJob < ApplicationJob
  def perform(sender, args)
    MessageSender.new(sender, args).call
  end
end
