class Course < ApplicationRecord
  
  #associations
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :booked_rooms, through: :booking, source: :room
  has_many :students, through: :enrollment, source: :user

  #validations
  validates(:title, presence: true, uniqueness: true, case_sensitive: false)
  validates(:description, presence: true, length: { minimum: 10 })
  validates :price, {presence: true, numericality: {greater_than: 0.0}}

  # Call Backs
  before_validation :set_default_value_price
  before_save :capitalize_course_title

  # Custom methods
  scope(:search, ->(query) { where("title ILIKE?", "%#{query}%") })

  private

  def set_default_value_price
    self.price ||= 1
  end

  def capitalize_course_title
      self.title.capitalize!
  end

end
