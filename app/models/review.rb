class Review < ApplicationRecord
  # associations 
  belongs_to :course
  belongs_to :user
  
  # validations
  validates :rating, 
    presence: true,
    numericality:{
      greater_than_or_equal_to: 1,
      less_than_equal_to: 5
    }

  validates :body, presence: true

end
