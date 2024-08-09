class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.all.with_attached_images
  end

  def show
    @post = current_user.posts.find_by(id: params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.images.attach(params[:post][:image])
    if @post.save!
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:text,:images)
  end
end
