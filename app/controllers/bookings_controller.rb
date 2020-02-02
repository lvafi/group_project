class BookingsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    before_action :find_booking, only: [:update, :destroy]
    before_action :authorize!, only: [:update, :destroy]


    def create
        @room = Room.find(params[:room_id])
        @booking = Booking.new booking_params
        @booking.room = @room
        if @booking.save
            flash[:success] = "Congratulations! You have booked a room."
            redirect_to room_path(@room)
        else
            puts @booking.errors.full_messages 
            redirect_to room_path(@room)
        end
    end

    def update
        @booking.update params[:status]
        redirect_to room_path(@booking.room)
    end

    def destroy
        @booking.destroy
        flash[:notice] = 'The booking has been deleted.'
        redirect_to room_path(@booking.room)
    end

    private

    def booking_params
        params.require(:booking).permit(:course_id, :room_id, :start_time, :end_time)
    end

    def find_booking
        @booking = Booking.find params[:id]
    end

    def authorize!
        find_booking
        unless can?(:crud, @booking)
            flash[:danger] = "Not Authorized"
            redirect_to room_path(@booking.room)
        end
    end
end
