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
        # 1. create new Recipe (title, cookbook_id, instructions)
        # 2. map through ingredients_attributes and make Ingredient (name), then RecipeIngredients (quantity, recipe_id, ingredient_id)
        # 3. save Recipe, send back json

        recipe = Recipe.create(title: params[:recipe][:title], cookbook_id: params[:recipe][:cookbook_id], instructions: params[:recipe][:instructions])

        ingredients = params[:ingredients_attributes]
        ingredients.map do |i|
            ing = Ingredient.create(name: i["name"])
            RecipeIngredient.create(quantity: i["quantity"], recipe_id: recipe.id, ingredient_id: ing.id)
        end
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
        params.require(:recipe).permit(:title, :instructions, :cookbook_id, ingredients_attributes: [:quantity, :name])
    end

end