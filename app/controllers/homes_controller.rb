class HomesController < ApplicationController
  before_action :authenticate_user!

  def search
    if params[:search].present?
      @users = User.where('username LIKE :search OR name LIKE :search', search: "%#{params[:search]}%")
     else
      @users = User.all
    end
  end

  def index
    @posts = Post.all.with_attached_images
  end
end
