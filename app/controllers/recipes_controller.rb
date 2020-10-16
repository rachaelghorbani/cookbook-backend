class RecipesController < ApplicationController

    def index
        recipes = Recipe.all
        render json: recipes
    end

    def show
        recipe = Recipe.find(params[:id])
        render json: recipe
    end

    def create
        recipe = Recipe.new(comment_params)
        if recipe.save
            render json: recipe
        else 
            render json: {error: recipe.errors.full_messages}, status: :not_acceptable
        end
    end

    def update
        recipe = Recipe.find(params[:id])
        if recipe.update(recipe_params)
            render json: recipe
        else
            render json: {error: recipe.errors.full_messages}, status: :not_acceptable
        end
    end

    def destroy
        recipe = Recipe.find(params[:id])
        recipe.destroy
        render json: recipe
    end

    private

    def recipe_params
        params.require(:recipe).permit(:title, :instructions, :cookbook_id)
    end

end