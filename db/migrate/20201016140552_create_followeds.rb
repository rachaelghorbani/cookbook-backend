class CreateFolloweds < ActiveRecord::Migration[6.0]
  def change
    create_table :followeds do |t|
      t.belongs_to :user
      t.belongs_to :cookbook
      t.timestamps
    end
  end
end
