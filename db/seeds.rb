require 'net/http'
require 'open-uri'
require 'json'
require 'uri'
require 'openssl'

User.all.destroy_all
Cookbook.all.destroy_all
Followed.all.destroy_all
Recipe.all.destroy_all
Ingredient.all.destroy_all
Photo.all.destroy_all
Comment.all.destroy_all
RecipeIngredient.all.destroy_all


def get_random_recipe
    url = URI("https://rapidapi.p.rapidapi.com/recipes/random?number=1")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
    request["x-rapidapi-key"] = ENV["SPOONACULAR_KEY"]

    response = http.request(request)
    rand_recipe = JSON.parse(response.body)
    recipe = rand_recipe["recipes"][0]
end

# We need to call this after we have created the CookBooks, Users
def createRecipeFromAPI(randRecipe)
    # make a recipe obj to create for our DB
    recipe = Recipe.create(title: randRecipe["title"], cookbook: Cookbook.all.sample, instructions: randRecipe["instructions"])
    ingredients = randRecipe["extendedIngredients"].map do |ing| 
        ingredient = Ingredient.find_or_create_by(name: ing["name"].titlecase)
        ri = RecipeIngredient.create(recipe: recipe, ingredient: ingredient, quantity: "#{ing["amount"]} #{ing["unit"]}")
    end
end

# Calling this at the bottom of code
def externalRecipeSeed
    5.times do
        api_recipe = get_random_recipe()
        createRecipeFromAPI(api_recipe)
    end
end

# Users
anson = User.create(first_name: "Anson", last_name: "Nickel", username: "anickel")
rachael = User.create(first_name: "Rachael", last_name: "Ghorbani", username: "rghorbani")
user1 = User.create(first_name: "Bob", last_name: "Ross", username: "bross")
user2 = User.create(first_name: "Jess", last_name: "Smith", username: "jsmith")
user3 = User.create(first_name: "Sarah", last_name: "Connor", username: "sconnor")
user4 = User.create(first_name: "Jason", last_name: "Baker", username: "jbaker")

# Cookbooks
cookbook1 = Cookbook.create(title: "Cooking101", owner: anson, description: "My Cookbook is the best cookbook ever.")
cookbook2 = Cookbook.create(title: "Faves", owner: anson, description: "My Cookbook is the best cookbook ever.")
cookbook3 = Cookbook.create(title: "Cooked", owner:rachael, description: "My Cookbook is the best cookbook ever.")
cookbook4 = Cookbook.create(title: "Family Recipes", owner: rachael, description: "My Cookbook is the best cookbook ever.")

# Recipes
recipe1 = Recipe.create(title: "BLT", cookbook: cookbook1, instructions: "Instructions go here!")

# Followeds
one = Followed.create(user: anson, cookbook: cookbook4)
two = Followed.create(user: user1, cookbook: cookbook4)

# Ingredients
ingredient1 = Ingredient.create(name: "Tomato")
ingredient2 = Ingredient.create(name: "Cucumber")
ingredient3 = Ingredient.create(name: "Lettuce")
ingredient4 = Ingredient.create(name: "Onion")

# RecipeIngredients
ri1 = RecipeIngredient.create(recipe: recipe1, ingredient: ingredient1, quantity: "1/4 Cup")
ri2 = RecipeIngredient.create(recipe: recipe1, ingredient: ingredient2, quantity: "1 teaspoon")

# Photos
photo1 = Photo.create(recipe: recipe1, img_url: "https://lh3.googleusercontent.com/proxy/ziFLd7ma9tvJsXe0cQ8FGBVh5KZ82lbhOe0bZgIx1Y_wGOeDWdWYNE2-QM6XHNNgKk31puvOwqTTcSXdwfNxOOoX1uYp5huIeBBl7SF9RduDqzMtbg")

# Comments
comment1 = Comment.create(content: "Great dish!", user: rachael, recipe: recipe1) 


externalRecipeSeed()
