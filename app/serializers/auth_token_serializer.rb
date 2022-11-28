class AuthTokenSerializer < ActiveModel::Serializer
  attributes :id,
    :user_id,
    :access_token,
    :device_name,
    :created_at,
    :updated_at

  belongs_to :client
end
