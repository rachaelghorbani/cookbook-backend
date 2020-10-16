class Recipe < ApplicationRecord
    belongs_to :cookbook
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    has_many :photos
    has_many :comments
end
