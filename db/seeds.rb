require 'net/http'
require 'open-uri'
require 'json'
require 'uri'
require 'openssl'
require 'faker'

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
    photo = Photo.create(recipe: recipe, img_url: randRecipe["image"], description: "test photo")
    ingredients = randRecipe["extendedIngredients"].map do |ing| 
        ingredient = Ingredient.find_or_create_by(name: ing["name"].titlecase)
        ri = RecipeIngredient.create(recipe: recipe, ingredient: ingredient, quantity: "#{ing["amount"]} #{ing["unit"]}")
    end
end

# Calling this at the bottom of code
def externalRecipeSeed
    20.times do
        api_recipe = get_random_recipe()
        createRecipeFromAPI(api_recipe)
    end
end

# Users
anson = User.create(first_name: "Anson", last_name: "Nickel", username: "anickel", password: "1234")
rachael = User.create(first_name: "Rachael", last_name: "Ghorbani", username: "rghorbani", password: "1234")
judy = User.create(first_name: "Judy", last_name: "Jetson", username: "jjetson", password: "1234")
val = User.create(first_name: "Val", last_name: "Vasquez", username: "vvasquez", password: "1234")
juan = User.create(first_name: "Juan", last_name: "Mire", username: "jmire", password: "1234")




# Cookbooks
cookbook1 = Cookbook.create(title: "Anson's Cookbook", owner: anson, description: "My family's favorite recipes!")
cookbook2 = Cookbook.create(title: Faker::Restaurant.name, owner: anson, description: "My favorite recipes.")
cookbook3 = Cookbook.create(title: Faker::Restaurant.name, owner:rachael, description: Faker::Restaurant.description)
cookbook4 = Cookbook.create(title: Faker::Restaurant.name, owner: User.all.sample, description: Faker::Restaurant.description)
cookbook5 = Cookbook.create(title: Faker::Restaurant.name, owner: User.all.sample, description: Faker::Restaurant.description )
cookbook6 = Cookbook.create(title: Faker::Restaurant.name, owner: User.all.sample, description: Faker::Restaurant.description)
cookbook7 = Cookbook.create(title: Faker::Restaurant.name, owner:User.all.sample, description: Faker::Restaurant.description)
cookbook8 = Cookbook.create(title: "Rachael's Cookbook", owner: rachael, description: Faker::Restaurant.description)

# Followeds
Followed.create(user: anson, cookbook: cookbook4)
Followed.create(user: rachael, cookbook: cookbook1)

# Comments



externalRecipeSeed()
50.times do
    Comment.create(content: Faker::Movie.quote, user_id: User.all.sample.id, recipe_id: Recipe.all.sample.id)
end