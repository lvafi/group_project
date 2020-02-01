class User < ApplicationRecord
    has_secure_password

    validates :is_admin?, default: false
    validates :email, presence: true, uniqueness: true,
    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    has_many :rooms, dependent: :destroy 
    has_many :booked_rooms , through: :booking, source: :room
    
    private

    def full_name
        "#{first_name} #{last_name}".strip.squeeze       
    end
end
