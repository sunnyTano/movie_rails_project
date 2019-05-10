class SessionsController < ApplicationController

    def new
      @errors = flash[:errors]
    end 

    def create
        user = User.find_by_username(params[:username])
        # If the user exists AND the password entered is correct.
        if user && user.authenticate(params[:password])
          # Save the user id inside the browser cookie. This is how we keep the user 
          # logged in when they navigate around our website.
          session[:user_id] = user.id
          redirect_to movies_path
        else
        # If user's login doesn't work, send them back to the login form.
          flash[:errors] = "User doesn't exist or invalid password"
          redirect_to '/login'
        end
      end
    
      def destroy
        session[:user_id] = nil
        redirect_to '/login'
      end
  
end