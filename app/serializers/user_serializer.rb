class UserSerializer < ActiveModel::Serializer
  attributes :id,
    :email,
    :last_seen_at,
    :created_at,
    :updated_at
end
