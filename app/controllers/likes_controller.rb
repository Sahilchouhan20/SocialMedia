class LikesController < ApplicationController
  before_action :instance_post,only:[:create]

  def create
    @like = @post.likes.new(like_params)
    @like.user_id = current_user.id
    @like.save
    redirect_to home_path(@post.id)
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @like.destroy
    redirect_to home_path
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id,:likeable_type)
  end

  def instance_post
    @post = Post.find_by(id: params[:like][:likeable_id])
  end
end
