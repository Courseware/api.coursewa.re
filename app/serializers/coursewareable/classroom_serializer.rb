# [Coursewareable::Classroom] serializer class
class Coursewareable::ClassroomSerializer < ActiveModel::Serializer
  attributes :id, :description, :title, :owner
  has_many :collaborations

  # Check if Classrooms#collaborators is called.
  def include_collaborations?
    if object[:include_collaborations]
      object
    end
  end
end
