class Feature < ApplicationRecord
    has_many :searches, dependent: :destroy
    has_many :rooms, through: :searches

    validates :name, presence: true, uniqueness: { case_sensitive: false }

end
