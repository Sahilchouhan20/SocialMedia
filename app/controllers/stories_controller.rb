class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_story
  before_action :remove_expired_stories

  def index
    @stories =  Story.active
    render layout: false
  end

  def show
    @user = @story.user
    @next_story = @user.stories.where('id > ?', @story.id).first
    @prev_story = @user.stories.where('id < ?', @story.id).last
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

  def find_story
    @story = Story.find_by(id: params[:id])
  end

  def remove_expired_stories
    Story.remove_expired
  end
end
