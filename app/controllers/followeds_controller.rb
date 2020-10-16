class FollowedCookbooksController < ApplicationController
    def create
        followed = Followed.new(followed_params)
        if followed.save 
            render json: followed
        else
            render json: {error: followed.errors.full_messages}, status: :not_acceptable
        end
    end

    private

    def followed_params
        params.require(:followed).permit(:user_id, :cookbook_id)
    end
end
end
