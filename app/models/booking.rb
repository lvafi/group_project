class Booking < ApplicationRecord
  belongs_to :course
  belongs_to :room
end
