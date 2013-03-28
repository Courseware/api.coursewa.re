# [Coursewareable::Lecture] serializer class
class Coursewareable::LectureSerializer < ActiveModel::Serializer
  attributes :id, :slug, :title, :content, :requisite
end
