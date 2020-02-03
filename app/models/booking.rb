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
  validate :available

  private

  def end_time_after_start_time    
    return if end_time.blank? || start_time.blank?
      if end_time < start_time      
        errors.add(:end_time, "Your end time must be after the start time.")    
      end 
  end

  def available
    conflicts = Booking.where(room_id: room_id)
      .where("start_time < ? AND end_time > ?", start_time, start_time)
      .or(Booking.where("start_time < ? AND end_time > ?", end_time, end_time))
      .or(Booking.where("start_time > ? AND end_time < ?", start_time, end_time))

    # puts "HERE IS A LIST OF OUR CONFLICTS"
    # p conflicts
    # puts "number of conflicts: " + conflicts.length.to_s
    # puts conflicts.exists?
    # puts !conflicts.exists?
    if conflicts.exists?
      errors.add(:start_time, "The time you have selected is unavailable. Please select another time slot.")
    end
  end

end
