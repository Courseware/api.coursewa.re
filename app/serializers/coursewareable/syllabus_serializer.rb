# [Coursewareable::Syllabus] serializer class
class Coursewareable::SyllabusSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :intro
  has_one :user
end
