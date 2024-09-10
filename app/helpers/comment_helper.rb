module CommentHelper
  def find_comment_user(comment)
    User.find_by(id: comment.user_id)
  end
end
