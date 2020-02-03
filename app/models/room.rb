class Room < ApplicationRecord
    belongs_to :user
    
    has_many :bookings, dependent: :destroy
    has_many :courses, through: :bookings

    has_many :searches, dependent: :destroy
    has_many :features, through: :searches
    has_many :availabilities, dependent: :destroy
    has_many :booker, through: :booking, source: :course

    validates :name, presence: true, uniqueness: { scope: :user_id }
    validates :address, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :capacity, presence: true, numericality: { greater_than: 0 }

    private 

    def capitalize_name
        self.name.capitalize!
    end

end
