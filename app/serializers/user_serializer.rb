class UserSerializer
  include JSONAPI::Serializer

  attributes :name, :email, :token
end