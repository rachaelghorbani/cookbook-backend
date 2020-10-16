class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.belongs_to :cookbook

      t.timestamps
    end
  end
end
