class HomesController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = current_user.posts.all.with_attached_images
  end

end
