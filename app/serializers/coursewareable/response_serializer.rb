# [Coursewareable::Response] serializer class
class Coursewareable::ResponseSerializer < ActiveModel::Serializer
  attributes :id, :content, :quiz
end
