# [Coursewareable::Assignment] serializer class
class Coursewareable::AssignmentSerializer < ActiveModel::Serializer
  attributes :id, :slug, :title, :content, :quiz
end
