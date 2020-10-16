class User < ApplicationRecord
    has_many :owned_cookbooks, :class_name => "Cookbook", foreign_key: :user_id
    has_many :followeds
    has_many :followed_cookbooks, :class_name => "Cookbook", through: :followeds, source: :cookbook
    has_many :comments
end
