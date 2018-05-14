class Message < ApplicationRecord
  belongs_to :entity, polymorphic: true

  validates :title, presence: true
end
