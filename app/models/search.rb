class Search < ApplicationRecord
    belongs_to :feature
    belongs_to :room
  
    validates :feature_id, uniqueness: { scope: :room_id }
end
