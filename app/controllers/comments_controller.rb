class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment

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
      puts @comment.errors.full_messages
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
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:discription, :user_id)
  end

  def find_post
    @post = Post.find_by(id: params[:post_id])
  end

  def find_comment
    @comment = Comment.find_by(id: params[:id])
  end
end
