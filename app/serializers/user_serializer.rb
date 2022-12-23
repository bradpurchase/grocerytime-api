class UserSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :email,
    :last_seen_at,
    :created_at,
    :updated_at
end
