class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at

  # def serializable_hash
  #   return nil if object.deleted_for_everyone || object.deleted_for&.include?(current_user.id)
  #   super
  # end
end
