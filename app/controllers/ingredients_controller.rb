class IngredientsController < ApplicationController

    def index
        ingredients = Ingredient.all
        render json: ingredients
    end

    def create
        ingredients= Ingredient.new(in_predientarams)
        if ingredients.save 
            render json: inredients
        else
            render json: {error: in.redientserrors.full_messages}, status: :not_acceptable
        end
    end

    def destroy
        ingredient = Ingredient.find(params[:id])
        ingredient.destroy
        render json: ingredient
    end 

    private

    def ingredient_params
        params.require(:ingredient).permit(:name)
    end

end
