class UsersController < ApplicationController

    def index
        users = User.all
        render json: users
    end

    def show
        user = User.find(params[:id])
        render json: user
    end

    def create
        # user = User.find_or_create_by(user_params)
        user = User.find_by(username: params[:user][:username])
        if user
            render json: user
        elsif !user
            user = User.create(user_params)
            render json: user
        # else
        #     render json: {error: user.errors.full_messages}, status: :not_acceptable
        end
    end

    def update
        user = User.find(params[:id])
        if user.update(user_params)
            render json: user
        else
            render json: {error: user.errors.full_messages}, status: :not_acceptable
        end
    end

    def destroy
        user = User.find(params[:id])
    
        user.destroy
    
        render json: user
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username)

    end

end
