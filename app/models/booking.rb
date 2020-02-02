class Booking < ApplicationRecord
  include AASM

  aasm do
    state :reserved, initial: true
    state :rejected, :approved

    event :approving do
      transitions from: :reserved, to: :approved
    end

    event :rejecting do
      transitions from: :reserved, to: :rejected
    end

    event :sleep do
      transitions from: [:rejected, :approved], to: :reserved
    end

  end
  
  belongs_to :course
  belongs_to :room
  
end
