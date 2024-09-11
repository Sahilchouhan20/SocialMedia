class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def index
    @posts = Post.all.with_attached_images
  end

  def show
    @post
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
      # Render the 'new' template with a 200 status to match the test expectation
      render :new, status: :ok
    end
  end

  def edit
    @post
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to homes_path
  end

  private

  def post_params
    params.require(:post).permit(:text,:images)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
  end

end
