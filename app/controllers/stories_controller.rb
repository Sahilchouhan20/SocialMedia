class StoriesController < ApplicationController
  before_action :instance_story

  def index
  end

  def show
    @story = current_user.stories.find_by(id: params[:id])
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.build(story_params)
    @story.stories.attach(params[:story][:stories])
    if @story.save!
      redirect_to homes_path, notice: 'story was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @story.destroy

    redirect_to homes_path
  end

  private

  def story_params
    params.require(:story).permit(:stories)
  end

  def instance_story
    @story = Story.find_by(id: params[:id])
  end

end
