# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
      
    user ||= User.new 
      
      if user.admin?
        can :manage, :all
      else
        can :read, :all
      end

      alias_action :create, :read, :update, :destroy, to: :crud

      can(:crud Room) do |room|
        room.user === user
      end

      can(:crud Course) do |course|
        course.user === user
      end

      # room.user == Room manager can manage booking instance
      can(:crud Booking) do |room|
        room.user === user
      end

      # course.user == Teacher can manage enrollment instance
      can(:crud Enrollment) do |course|
        course.user === user
      end

  end
end
