class IngredientsController < ApplicationController

    def index
        ingredients = Ingredient.all
        render json: ingredients
    end

    def create
        in redients= Ingredient.new(in_predientarams)
        if in.redientssave 
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
