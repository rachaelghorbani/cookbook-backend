class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :cookbook_id, :title, :ingredients, :comments, :photos, :instructions

  def ingredients 
    object.recipe_ingredients.map do |ri|
      {quantity: ri.quantity, name: ri.ingredient.name}
    end
  end

  def photos
    object.photos.map do |p|
      {img_url: p.img_url, description: p.description}
    end
  end

  def comments
    object.comments.map do |c|
      {content: c.content, commenter: c.user.full_name, created_at: c.created_at.strftime("%A, %d %b %Y %l:%M %p")}
    end
  end
end