class Recipe < ApplicationRecord
    belongs_to :cookbook
    has_many :recipe_ingredients, dependent: :destroy
    has_many :ingredients, through: :recipe_ingredients
    has_many :photos, dependent: :destroy
    has_many :comments, dependent: :destroy
end
