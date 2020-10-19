class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :owned_cookbooks, :followed_cookbooks

  def name
    object.full_name
  end

  def recipes(cb)
      cb.recipes.map do |r|

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
        
        {id: r.id, cookbook_id: r.cookbook_id, title: r.title, instructions: r.instructions, photos: photos, comments: comments,  ingredients: ingredients}
      end
  end

  def owned_cookbooks
    object.owned_cookbooks.map do |oc|
        {id: oc.id, owner_id: oc.owner.id, title: oc.title, recipes: recipes(oc)}
    end
  end

  def followed_cookbooks
    object.followed_cookbooks.map do |fc|
        {id: fc.id, owner_id: fc.user_id, title: fc.title, recipes: recipes(fc)}
    end
  end


end
