# [Coursewareable::User] serializer class
class Coursewareable::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name
end
