class HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.with_attached_images
  end

end
