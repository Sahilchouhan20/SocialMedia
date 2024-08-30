class LikesController < ApplicationController
  before_action :find_likeable,only:[:create]

  def index
    @post = Post.find_by(id: params[:post_id])
    begin
      @likes = @post.likes
    rescue StandardError=>e
      redirect_to homes_path
    end

  end

  def create
    @like = @likeable.likes.new(like_params)
    @like.user_id = current_user.id
    @like.save
    redirect_to homes_path
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @likeable = @like
    @like.destroy
    redirect_to @likeable
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id,:likeable_type)
  end

  def find_likeable
    @likeable = if params[:like][:likeable_type] == "Post"
                  Post.find_by(id: params[:like][:likeable_id])

                elsif params[:like][:likeable_type] == "Story"
                  Story.find_by(id: params[:like][:likeable_id])
                else
                  Comment.find_by(id: params[:like][:likeable_id])
                end
  end
end
