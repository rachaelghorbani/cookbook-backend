class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :recipe_id, :user
  
  belongs_to :user

  def user
    obj = object.user
    {first_name: obj.first_name, last_name: obj.last_name, username: obj.username, user_id: obj.id}
  end

end
