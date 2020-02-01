class Room < ApplicationRecord
    # belongs_to :user
    
    # has_many :bookings, dependent: :destroy
    # ha_many :courses, dependent: :nullify

    has_many :searches, dependent: :destroy
    has_many :features, through: :searches
    has_many :bookings, dependent: :destroy
    has_many :courses, dependent: :nullify
    has_many :booker, through: :booking, source: :course

    validates :name, presence: true#, uniqueness: { scope: :user_id }
    validates :address, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 
    validates :capacity, presence: true, numericality: { greater_than: 0 }

    # Getter
    def features
        self.features.map{ |t| t.name }.join(", ")
    end

    # Setter
    def features=(value)
        self.tags = value.strip.split(/\s*,\s*/).map do |feature|
            Tag.find_or_initialize_by(name: feature)
        end
    end

    private 

    def capitalize_name
        self.name.capitalize!
    end

end
