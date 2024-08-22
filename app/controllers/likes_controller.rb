class LikesController < ApplicationController
  before_action :find_likeable

  def create
    @likes = @likeable.likes.new(like_params)
    @likes.user_id = current_user.id
    @likes.save
    redirect_to home_path(@likeable.id)
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @like.destroy
    redirect_to home_path(@likeable.id)
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id,:likeable_type)
  end

  def find_likeable
    @likeable = params[:like][:likeable_type].constantize.find(params[:like][:likeable_id])
  end
end
