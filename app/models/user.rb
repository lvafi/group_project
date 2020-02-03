class User < ApplicationRecord
    has_secure_password

    validates :is_admin?, default: false
    validates :email, presence: true, uniqueness: true,
    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    has_many :rooms, dependent: :nullify
    has_many :courses, dependent: :nullify 
    has_many :reviews, dependent: :destroy
    has_many :enrolled_courses, through: :enrollment, source: :course   
    has_many :enrollments, dependent: :destroy  

    def full_name
        "#{first_name} #{last_name}"      
    end
end
