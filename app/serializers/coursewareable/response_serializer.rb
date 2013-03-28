# [Coursewareable::Response] serializer class
class Coursewareable::ResponseSerializer < ActiveModel::Serializer
  attributes :id, :content, :quiz
  has_one :user
end
