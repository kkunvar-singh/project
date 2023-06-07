class SessionsController < ApplicationController

    def new 
    end

    def create 
      user = User.find_by(email: permit_params[:email])
      if user && user.authenticate(permit_params[:password])
        if user.confirmed? || user.forget_password?
          session[:user_id] = user.id
          redirect_to root_path, notice: 'User Successfully Log-In'
        else
          redirect_to new_session_path, notice: 'Please confirmed your account first'
        end
      else
        flash.now[:alert] = 'Invalid email/password combination'
        render  :new, status: :unprocessable_entity
      end 
    end

    def permit_params
      params.require(:session).permit(:email, :password)
    end

    def destroy
      session[:user_id] = nil
      flash[:notice] = "successfully logged out"
      redirect_to root_path
    end
end
