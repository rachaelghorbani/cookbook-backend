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