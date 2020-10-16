class Cookbook < ApplicationRecord
    # has_many :recipes
    belongs_to :owner, :class_name =>"User", :foreign_key => "user_id"
    has_many :followed
    has_many :followers, :class_name =>"User", through: :followed, source: :user
    has_many :recipes
    has_many :photos, through: :recipes
end
