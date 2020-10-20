class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create, :index, :current]

    def index
        users = User.all
        render json: users
    end

    def show
        user = User.find(params[:id])
        render json: user
    end

    def current
        render json: {user: current_user}, status: :accepted
    end

    def create
        user = User.create(user_params)
        if user.valid?
            token = encode_token(user_id: user.id)
            render json: { user: user, jwt: token }, status: :created
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
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
        params.require(:user).permit(:first_name, :last_name, :username, :password)

    end

end
