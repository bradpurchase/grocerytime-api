class StoreUserSerializer < ActiveModel::Serializer
  attributes :id,
    :store_id,
    :user_id,
    :creator,
    :active,
    :default_store,
    :created_at,
    :updated_at,
    :user

  def user
    {
      id: object.user.id,
      email: object.user.email,
      name: object.user.name
    }
  end
end
