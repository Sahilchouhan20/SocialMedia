class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path,status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :username, :bio)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
