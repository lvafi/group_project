class Review < ApplicationRecord
  # associations 
  belongs_to :course
  belongs_to :user

  #has_many :reviewers, through: reviews, source: :user 
  
  # validations
  validates :rating, {
    numericality:{
      greater_than_or_equal: 1,
      less_than_equal_to: 5,
    },
  end
end

