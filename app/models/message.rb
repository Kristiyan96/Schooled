class Message < ApplicationRecord
  belongs_to :sender, polymorphic: true
  belongs_to :recipient, polymorphic: true
end
