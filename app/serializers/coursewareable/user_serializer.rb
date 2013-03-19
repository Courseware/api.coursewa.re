# [Coursewareable::User] serializer class
class Coursewareable::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name
  has_one :plan

  has_many :created_classrooms
  has_many :memberships
  has_many :collaborations
  has_many :membership_classrooms
  has_many :collaboration_classrooms
  has_many :sent_invitations
end
