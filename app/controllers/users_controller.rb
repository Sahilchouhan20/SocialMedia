class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
   @user = User.where(params[:id]).pluck(:name, :username, :bio)
  end

  def show
    @user = current_user
  end

  def new
    @user = current_user.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save == 'active'
      redirect_to @user
    else
      render "new"
    end
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def update
  #   @user = User.find(params[:id])

  #   if @user.update(user_params)
  #     redirect_to @user
  #   else
  #     render :edit, status: :"profile can't be edit"
  #   end
  # end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy

  #   redirect_to root_path,status: :"Your id is not destory"
  # end


end
