class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update]
    
    def new
        @user = User.new 
    end

    def create
        @user = User.new user_params
        if @user.save
            flash[:success] = "User created"
            sessions[:user_id] = @user.id
            redirect_to root_path
        else
            flash[:alert] = @user.errors.full_messages.join(", ")
            render :new
        end
    end

    def edit
    end

    def update
        if @user.update user_params
            flash[:success] = "User info updated"
            sessions[:user_id] = @user.id
            redirect_to root_path
        else
            render :edit
        end
    end

    private

    def user_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :email.
            :password,
            )
    end

    def find_user
        @user = User.find params[:id]
    end

end
