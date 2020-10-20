class CookbooksController < ApplicationController
    skip_before_action :authorized, only: [:index, :create]

    def index
        cookbooks = Cookbook.all 
        render json: cookbooks
    end

    def show
        cookbook = Cookbook.find(params[:id])
        render json: cookbook
    end

    def create
        cookbook = Cookbook.new(cookbook_params)
        if cookbook.save
            render json: cookbook
        else
            render json: {error: cookbook.errors.full_messages}, status: :not_acceptable
        end
    end

    def update 
        cookbook = Cookbook.find(params[:id])
        if cookbook.update(cookbook_params)
            render json: cookbook
        else
            render json: {error: cookbook.errors.full_messages}, status: :not_acceptable
        end
    end

    def destroy
        cookbook = Cookbook.find(params[:id])
        cookbook.destroy
        render json: cookbook
    end 

    private

    def cookbook_params 
        params.require(:cookbook).permit(:title, :user_id, :description)
    end

end
