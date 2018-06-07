class Message < ApplicationRecord
  belongs_to :sender, foreign_key: "sender_id", class_name: "User"
  belongs_to :recepient, foreign_key: "recepient_id", class_name: "User"

  def self.send_multiple(sender, args)
    args[:user_id]
  end
end
