class CommentsController < ApplicationController
  before_action :instance_post
  before_action :instance_comment

  def index
    @comments = @post.comments

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
      redirect_to post_path(@post)
    else
      redirect_to 'edit',status: :"comment can't be update"
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
  def comment_params
    params.require(:comment).permit(:discription)
  end

  def instance_post
    @post = Post.find_by(id: params[:post_id])
  end

  def instance_comment
    @comment = Comment.find_by(id: params[:id])
  end
end
