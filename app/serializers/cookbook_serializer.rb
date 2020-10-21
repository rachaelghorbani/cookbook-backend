class CookbookSerializer < ActiveModel::Serializer
  attributes :id, :title, :owner, :description, :followers, :recipes 

  def owner 
      {owner_name: object.owner.full_name, owner_id: object.owner.id}
  end

  def followers
    object.followeds.map do |f|
        {followed_id: f.id, follower_name: f.user.full_name, follower_id: f.user_id }
    end
  end

  def recipes
    object.recipes.map do |r|

      ingredients = []
      r.recipe_ingredients.map do |ri|
        ingredients.push({quantity: ri.quantity, name: ri.ingredient.name})
      end

      photos = []
      r.photos.map do |p|
        photos.push({img_url: p.img_url, description: p.description})
      end

      comments = []
      r.comments.map do |c|
        comments.push({content: c.content, commenter: c.user.full_name, created_at: c.created_at.strftime("%A, %d %b %Y %l:%M %p")})
      end
      
      {id: r.id, cookbook_id: r.cookbook_id, title: r.title, instructions: r.instructions, photos: photos, comments: comments, ingredients: ingredients}
    
    end

  end
  
end



