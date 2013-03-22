# [Coursewareable::Classroom] serializer class
class Coursewareable::ClassroomSerializer < ActiveModel::Serializer
  attributes :id, :description, :title, :owner
end
