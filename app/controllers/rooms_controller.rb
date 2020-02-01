class RoomsController < ApplicationController
    # before_action :authenticate_user!, except: [:index, :show]
    before_action :find_room, only: [:edit,:update,:show, :destroy]
    # before_action :authorize!, only: [:edit, :update, :destroy]

    def new
        @room = Room.new
    end

    def create
        @room = Room.new room_params
        # @room.user = current_user
        if @room.save
            flash[:notice] = 'Room created successfully'
            redirect_to room_path(@room.id)
        else
            render :new
        end
    end

    def edit
        
    end

    def update
        if @room.update room_params
            flash[:notice] = 'Room updated Successfully'
            redirect_to room_path(@room.id)
        else
            render :edit
        end
    end

    def index
        if params[:feature]
            @feature = Feature.find_or_initialize_by(name: params[:feature])
            @rooms = @feature.rooms.order(created_at: :desc)
        else
            @rooms = Rooms.all.order(created_at: :desc)
        end
    end

    def show
    end

    def destroy
        @room.destroy
        redirect_to rooms_path
    end

    private

    def find_room
        @room = Room.find params[:id]
    end
    
    def room_params
        params.require(:room).permit(:name, :address, :capacity, :price, :description, :features)
    end

    # def authorize!
    #     unless can?(:crud, @room)
    #         redirect_to root_path, alert: 'Not Authorized'
    #     end
    # end

end
