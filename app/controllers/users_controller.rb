class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login!(@user)
            redirect_to goals_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = User.where(id: params[:id]).includes(:goals).first
        @user ||= current_user
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end

end
