# [PublicActivity::Activity] serializer class
class Coursewareable::ActivitySerializer < ActiveModel::Serializer
  attributes :id, :recipient_type, :trackable_type
  has_one :owner, :recipient, :trackable

  def recipient_type
    @object.recipient_type.to_s.underscore
  end

  def trackable_type
    @object.trackable_type.to_s.underscore
  end
end
