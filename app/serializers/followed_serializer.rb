class FollowedSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :cookbook_id
end
