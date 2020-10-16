User.all.destroy_all
Cookbook.all.destroy_all
Followed.all.destroy_all


anson = User.create(first_name: "Anson", last_name: "Nickel", username: "anickel")

rachael = User.create(first_name: "Rachael", last_name: "Ghorbani", username: "rghorbani")



cookbook1 = Cookbook.create(title: "Cooking101", owner: anson)
cookbook2 = Cookbook.create(title: "Faves", owner: anson)
cookbook3 = Cookbook.create(title: "Cooked", owner:rachael)
cookbook4 = Cookbook.create(title: "Family Recipes", owner: rachael)


user1 = User.create(first_name: "user1", last_name: "user1", username: "user1")
user2 = User.create(first_name: "user2", last_name: "user2", username: "user2")
user3 = User.create(first_name: "user3", last_name: "user3", username: "user3")
user4 = User.create(first_name: "user4", last_name: "user4", username: "user4")

one = Followed.create(user: anson, cookbook: cookbook4)
two = Followed.create(user: user1, cookbook: cookbook4)

ingredient1 = Ingredient.create(name: "Tomato")
ingredient2 = Ingredient.create(name: "Cucumber")
ingredient3 = Ingredient.create(name: "Lettuce")
ingredient4 = Ingredient.create(name: "Onion")


recipe1 = Recipe.create(title: "BLT", cookbook: cookbook1)

ri1 = RecipeIngredient.create(recipe: recipe1, ingredient: ingredient1)
ri2 = RecipeIngredient.create(recipe: recipe1, ingredient: ingredient2)

photo1 = Photo.create(recipe: recipe1, img_url: "https://lh3.googleusercontent.com/proxy/ziFLd7ma9tvJsXe0cQ8FGBVh5KZ82lbhOe0bZgIx1Y_wGOeDWdWYNE2-QM6XHNNgKk31puvOwqTTcSXdwfNxOOoX1uYp5huIeBBl7SF9RduDqzMtbg")

comment1 = Comment.create(content: "Great dish!", user: user1, recipe: recipe1) 
