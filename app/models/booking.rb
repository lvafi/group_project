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

  end
  
  belongs_to :course
  belongs_to :room
  
  validates :start_time, :end_time, presence: true  
  validate :end_time_after_start_time

  private

  def end_time_after_start_time    
    return if end_time.blank? || start_time.blank?
      if end_time < start_time      
        errors.add(:end_time, "must be after the start time")    
      end 
  end

end
