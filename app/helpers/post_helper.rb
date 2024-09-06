module PostHelper
  def find_user(id)
    User.find_by(id: Post.find(id).likes.last.user_id)
  end
end
