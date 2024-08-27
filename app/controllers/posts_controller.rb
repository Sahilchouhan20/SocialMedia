class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :instance

  def index
    @posts = Post.all.with_attached_images
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

  def edit
    @post
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :"profile can't be edit"
    end
  end

  def destroy
    @post.destroy

    redirect_to homes_path,status: :"Your id is not destory"
  end

  private
  def post_params
    params.require(:post).permit(:text,:images)
  end

  def instance
    @post = Post.find_by(id: params[:id])
  end
end
