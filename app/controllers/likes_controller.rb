class LikesController < ApplicationController
  before_action :instance_used,only:[:create]

  def create
    @likes = @post.likes.new(like_params)
    @likes.user_id = current_user.id
    @likes.save
    redirect_to home_path(@post.id)
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @like.destroy
    redirect_to home_path
  end

  private

  def like_params
    debugger
    params.require(:like).permit(:likeable_id,:likeable_type)
  end

  def instance_used
    @post = Post.find_by(id: params[:like][:likeable_id])
    @comment = Comment.find_by(id: params[:id])
  end
end
