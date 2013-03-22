class Coursewareable::CollaborationSerializer < ActiveModel::Serializer
  attributes :id, :user, :type
end
