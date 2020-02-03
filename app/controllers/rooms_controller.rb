class RoomsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_room, only: [:show, :edit, :update, :destroy]
    before_action :authorize!, only: [:edit, :update, :destroy]

    def new
        @room = Room.new
    end

    def create
        @room = Room.new room_params
        @room.user = current_user

        if params[:features]
            @room.features = params[:features].map do |feature|
                Feature.find_or_initialize_by(name: feature)
            end
        end

        if @room.save
            flash[:notice] = 'Congratulations! You have created a room.'
            redirect_to room_path(@room.id)
        else
            render :new
        end
    end

    def edit

    end

    def update

        if params[:features]
            @room.features = params[:features].map do |feature|
                Feature.find_or_initialize_by(name: feature)
            end
        end
        
        if @room.update room_params
            flash[:notice] = 'Room updated successfully'
            redirect_to room_path(@room.id)
        else
            render :edit
        end
    end

    def index
        if params[:feature]
            @feature = Feature.find_or_initialize_by(name: params[:feature])
            @rooms = @feature.rooms.order(created_at: :desc)
        elsif params[:location]
            @rooms = Room.all.filter { |room| room.location == params[:location] }
            @location = params[:location]
        else
            @rooms = Room.all.order(created_at: :desc)
        end
    end

    def show
        @availability = Availability.new
        @availabilities = @room.availabilities.order(created_at: :desc)
        @booking = Booking.new
        @bookings = Booking.all.order(created_at: :desc)
    end

    def destroy
        @room.destroy
        flash[:notice] = 'The room was successfully deleted.'
        redirect_to rooms_path
    end

    private

    def find_room
        @room = Room.find params[:id]
    end
    
    def room_params
        params.require(:room).permit(:name, :location, :address, :capacity, :price, :description, :features)
    end

    def new_params
    end

    def authorize!
        unless can?(:crud, @room)
            redirect_to root_path, alert: 'Not Authorized'
        end
    end

end
