class Availability < ApplicationRecord
    belongs_to :room

    validates :start, presence: true, uniqueness: { scope: :room_id }
    validates :end, presence: true, uniqueness: { scope: :room_id }
end
