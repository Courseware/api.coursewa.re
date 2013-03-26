class LectureSerializer < ActiveModel::Serializer
  attributes :id, :slug, :title, :content, :requisite
end
