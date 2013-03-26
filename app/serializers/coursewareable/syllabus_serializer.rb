class SyllabusSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :intro
end
