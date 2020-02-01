class AvailabilitiesController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @room = Room.find params[:room_id]
        @availability = Availability.new availability_params
        @availability.user = current_user
        @availability.room = @room

        if @availability.save
            redirect_to room_path(@room)
        else
            @availabilities = @room.availabilities.order(created_at: :desc)
            render 'rooms/show'
        end
    end

    def destroy
        @availability = Availability.find params[:id]
        if can? :crud, @availability
            @availability.destroy
            redirect_to room_path(@availability.room)
        else
            redirect_to root_path, alert: 'Not Authorized'
        end
    end

end
