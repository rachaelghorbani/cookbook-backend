class FollowedsController < ApplicationController
    skip_before_action :authorized, only: [:index]

    def index
        followeds = Followed.all
        render json: followeds
    end

    def create
        followed = Followed.create(followed_params)
        cookbook = Cookbook.find(followed_params["cookbook_id"])
        if followed.save 
            render json: cookbook
        else
            render json: {error: followed.errors.full_messages}, status: :not_acceptable
        end
    end

    def destroy
        followed = Followed.find(params[:id])
        cookbook_id = followed.cookbook_id
        followed.destroy
        cookbook = Cookbook.find(cookbook_id)

        render json: cookbook
    end

    private

    def followed_params
        params.require(:followed).permit(:user_id, :cookbook_id)
    end

end
