module LikeHelper
  def find_like(likeable)
    current_user.likes.find_by(likeable: likeable)
  end
end
