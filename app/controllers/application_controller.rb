class ApplicationController < ActionController::Base

    private

    def current_user
        if session[:user_id].present?
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end
    helper_method :current_user

    def authenticate_user
        unless session[user_id].present?
            flash[:danger] = "User must Sign In"
            redirect_to new_session_path
        end
    end
    helper_method :authenticate_user
    
end
