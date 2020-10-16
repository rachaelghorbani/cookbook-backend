class Cookbook < ApplicationRecord
    # has_many :recipes
    belongs_to :owner, :class_name =>"User", :foreign_key => "user_id"
    has_many :followed
    has_many :followers, :class_name =>"User", through: :followed, source: :user
end
