# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
     
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud

    if user.is_admin?
      can :manage, :all
    end

    can :crud, User, :id => user.id

    can(:crud, Course) do |course|
      course.user == user
    end
    
    can(:crud, Room) do |room|
      room.user == user 
    end

    can(:crud, Booking) do |booking|
      booking.course.user == user || booking.room.user == user
    end

    can(:crud, Enrollment) do |enrollment|
      enrollment.user == user #only a student can enroll, not a teacher of a course
      #|| enrollment.course.user == user
    end

  end
end
