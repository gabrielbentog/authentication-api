class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :auth_token
end
