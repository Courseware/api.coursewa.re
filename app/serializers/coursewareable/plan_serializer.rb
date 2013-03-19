# [Coursewareable::Plan] serializer class
class Coursewareable::PlanSerializer < ActiveModel::Serializer
  attributes(:id, :allowed_classrooms, :allowed_space, :allowed_collaborators,
             :expires_in, :slug, :used_space)
end
