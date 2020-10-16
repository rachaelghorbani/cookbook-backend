class RecipeIngredientsController < ApplicationController
    def create
        ri = RecipeIngredient.new(recipe_ingredient_params)
        if ri.save 
            render json: ri
        else
            render json: {error: ri.errors.full_messages}, status: :not_acceptable
        end
    end

    private

    def recipe_ingredient_params
        params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id, :quantity)
    end
end
