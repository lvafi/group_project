class Enrollment < ApplicationRecord
  include AASM

  aasm do
  end
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
  end
  
  belongs_to :course
  belongs_to :user

  validates :user_id, uniqueness: {scope: :course_id}
end
