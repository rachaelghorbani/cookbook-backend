class User < ApplicationRecord
    has_many :owned_cookbooks, :class_name => "Cookbook", foreign_key: :user_id, dependent: :destroy
    has_many :followeds, dependent: :destroy
    has_many :followed_cookbooks, :class_name => "Cookbook", through: :followeds, source: :cookbook
    has_many :comments

    def full_name
       fullname = "#{self.first_name} #{self.last_name}"
       fullname.downcase.titlecase
    end

end
