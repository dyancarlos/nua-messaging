class Message < ApplicationRecord
  belongs_to :inbox
  belongs_to :outbox

  scope :unread, -> { where(read: false) }
end
