class CommentsController < ApplicationController
  def index
    @post = Post.find(1)
    @comment = @post.comments
  end

  def show
    @post = Post.find(1)
    @comment = @post.comments
  end

  def new
    @comment = @post.comments.new(comment_params)
  end

  def create
    @post = Post.find_by(id:1)
    @comment = @post.comments.create(comment_params)
    if @comment.save
      redirect_to @post
    else
      render "new"
    end
  end

  # def edit
  #   @comment = Comment.find(comment_param)
  # end

  # def update
  #   @comment = Comment.find(comment_param)

  #   if @comment.update(comment_params)
  #     redirect_to 'show'
  #   else
  #     redirect_to 'edit',status: :"comment can't be update"
  #   end
  # end

  # def destroy
  #   @comment = Comment.find(comment_param)
  #   @comment.destroy

  #   redirect_to "index",status: :"try again"
  # end

  private
  def comment_params
    params.require(:comment).permit(:discription)
  end
end
