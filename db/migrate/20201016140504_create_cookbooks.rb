class CreateCookbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :cookbooks do |t|
      t.string :title
      t.belongs_to :user
      t.timestamps
    end
  end
end




# class Cookbook
#   belongs_to :owner, :class_name =>"User", :foreign_key => "owner_id"
#   has_many :followeds
#   has_many :users, through: :followeds