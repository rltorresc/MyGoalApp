class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user, :require_login, :check_goal_owner
    before_action :set_current_user
    def login!(user)
        session[:session_token] = user.reset_session_token!
        cookies.signed[:session_token] = { value: user.session_token, expires: 1.day.from_now }
    end

    def logout!
        current_user.reset_session_token!
        session[:session_token] = nil
        cookies.signed[:session_token] = nil
    end

    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def set_current_user
        @current_user = current_user
    end

    def require_login
        unless current_user
            flash[:errors] = "You must be logged in to create a goal"
            redirect_to new_session_url
        end
    end
    def check_goal_owner
        @goal = Goal.find(params[:id])
        unless @goal.user_id == current_user.id
            flash[:errors] = "You are not authorized to edit this goal"
            redirect_to goal_url(@goal)
        end
    end

end
