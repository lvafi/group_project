class Review < ApplicationRecord
  # associations 
  belongs_to :course
  belongs_to :user
  
  # validations
  validates :rating, 
    presence: true,
    numericality:{
      greater_than_or_equal: 1,
      less_than_equal_to: 5
    }
  end

end
