class ApplicationController < ActionController::Base
    include Pundit::Authorization 
    
    helper_method :current_user

    private
  
    def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
    end

    def current_user
        if session[:user_id]
            @current_user ||=  User.find_by(id: session[:user_id])
        else
            @current_user = nil
        end
        @current_user
    end

    def verify_auth_user
        if current_user.nil?
            flash[:alert] = "You'r not authorize to perfom this action"
            redirect_to new_session_path 
        end
    end

end
