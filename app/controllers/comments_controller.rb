class CommentsController < ApplicationController
  before_action :instance_used
  before_action :authenticate_user!

  def show
    @comment = @post.comments
  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to @post
    else
      render "new"
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update

    if @comment.update(comment_params)
      redirect_to "/posts/#{@post.id}"
    else
      redirect_to 'edit',status: :"comment can't be update"
    end
  end

  def destroy
    @comment.destroy

    redirect_to "/posts/#{@post.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:discription)
  end

  def instance_used
    @post = current_user.posts.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])
  end
end
