class Cookbook < ApplicationRecord
    belongs_to :owner, :class_name =>"User", :foreign_key => "user_id"
    has_many :followeds, dependent: :destroy
    has_many :followers, :class_name =>"User", through: :followeds, source: :user
    has_many :recipes, dependent: :destroy
    has_many :photos, through: :recipes
end
