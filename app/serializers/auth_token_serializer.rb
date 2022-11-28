class AuthTokenSerializer < ActiveModel::Serializer
  attributes :id,
    :client_id,
    :access_token,
    :device_name,
    :created_at,
    :updated_at

  belongs_to :client
end
