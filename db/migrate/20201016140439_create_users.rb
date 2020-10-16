class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.timestamps
    end
  end
end


# class User
#   has_many :cookbooks
#   has_many :followeds
#   has_many :followed_cookbooks, :class_name => "Cookbook", through: :followeds, source: :followed
