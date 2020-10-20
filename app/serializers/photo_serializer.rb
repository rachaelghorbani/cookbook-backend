class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :img_url, :recipe_id
end
