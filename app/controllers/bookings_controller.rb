class BookingsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    before_action :find_booking, only: [:update, :destroy]
    before_action :authenticate!, only: [:update, :destroy]


    def create
        @booking = Booking.new booking_params
        if @booking.save
            flash[:success] = "Booked successfully"
            redirect_to room_path(@booking.room)
        else
            render room_path(@booking.room)
        end
    end

    def update
        @booking.update params[:status]
        redirect_to room_path(@booking.room)
    end

    def destroy
        @booking.destroy
        redirect_to room_path(@booking.room)
    end

    private

    def booking_params
        params.require(:booking).permit(:course_id, :room_id, :start_time, :end_time)
    end

    def find_booking
        @booking = Booking.find params[:id]
    end

    def authenticate!
        find_booking
        unless can?(:crud, @booking)
            flash[:danger] = "Not Authorized"
            redirect_to room_path(@booking.room)
        end
    end
end
