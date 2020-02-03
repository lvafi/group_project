class UsersController < ApplicationController

    before_action :authenticate_user!, except: [:new, :create]
    before_action :authenticate!, only: [:edit, :update, :destroy]
    before_action :find_user, only: [:edit, :update, :destroy, :password_edit, :password_update]


    def new
        @user = User.new 
    end

    def create
        @user = User.new user_params
        if @user.save
            flash[:success] = "User created"
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @user.update user_params
            flash[:success] = "User info updated"
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :edit
        end
    end


    def show
        @user = current_user
    end
  
    def update_password
        if @user&.authenticate params[:current_password]
            user_params[:password] = params[:id][:new_password] 
            if @user.update user_params
                flash[:notice] = "You have updated your password."
                redirect_to root_path
            else
                flash[:alert] = "Password update failed. Please make sure your new password matches its confirmation."
                render :edit_password
            end
        else
            render :edit_password, alert: "Your current password does not match our records."
        end
    end
    
    def edit_password
    end

    private

    def user_params
        params.require(:user).permit(
            :first_name, :last_name, :email, :password, :password_confirmation
        )
    end

    def find_user
        @user = User.find params[:id]
    end

    def authenticate!
        find_user
        unless session[:user_id] === @user.id
            flash[:danger] = "Not Authorized"
            redirect_to root_path
        end
    end

end
