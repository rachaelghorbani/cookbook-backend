Rails.application.routes.draw do
  resources :comments
  resources :photos
  resources :ingredients
  resources :recipe_ingredients
  resources :recipes
  resources :followeds
  resources :cookbooks
  resources :users

  post '/login', to: 'auth#create'

  get '/', to: 'users#current'
 


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
