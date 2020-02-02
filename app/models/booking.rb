class Booking < ApplicationRecord
  include AASM

  aasm do
    state :reserved, initial: true
    state :rejected, :approved

    event :approving do
      transitions from: :reserved, to: :approved
    end

    event :rejecting do
      after do
        self.destroy
      end
      transitions from: :reserved, to: :rejected
    end

    event :reserving do
      transitions from: [:rejected, :approved], to: :reserved
    end

  end
  
  belongs_to :course
  belongs_to :room

end
