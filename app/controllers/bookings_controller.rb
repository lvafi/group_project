class BookingsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    before_action :find_booking, only: [:update, :destroy]
    before_action :authorize!, only: [:update, :destroy]


    def create
        @room = Room.find(params[:room_id])
        @booking = Booking.new booking_params
        @booking.course.user = current_user
        @booking.room = @room
        if @booking.save
            flash[:success] = "Congratulations! You have booked a room."
            redirect_to room_path(@room)
        else
            @bookings = @room.bookings.order(created_at: :desc)
            render 'rooms/show'
        end
    end

    def edit
        @room = Room.find params[:room_id]
        @booking = Booking.find params[:id]
        @bookings = @room.bookings.order(created_at: :desc)
        @courses  = current_user.courses
    end

    def update
        @booking.update booking_params
        redirect_to room_path(@booking.room)
    end

    def destroy
        @booking.destroy
        flash[:notice] = 'The booking has been deleted.'
        redirect_to room_path(@booking.room)
    end

    def approving
        @booking = Booking.find(params[:booking_id])
        @booking.approving!
        redirect_to room_path(@booking.room)
    end

    def rejecting
        @booking = Booking.find(params[:booking_id])
        @booking.rejecting!
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
