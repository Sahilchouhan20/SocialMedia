require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:story) { create(:story, user: user) }

  before do
    sign_in user  # Ensure user is signed in for actions that require authentication
  end

  describe "GET #index" do
    let!(:active_story) { create(:story, created_at: 1.hour.ago) }
    let!(:old_story) { create(:story, created_at: 2.days.ago) }

    before do
      get :index
    end

    it "assigns @stories" do
      expect(assigns(:stories)).to match_array(Story.active)
    end
  end

  describe "GET #show" do
    let!(:user) { create(:user) }
    let!(:story1) { create(:story, user: user, created_at: 1.hour.ago) }
    let!(:story2) { create(:story, user: user, created_at: 1.hour.ago) }
    let!(:story3) { create(:story, user: user, created_at: 1.hour.ago) }

    before do
      get :show, params: { id: story2.id }
    end

    it "assigns @story" do
      expect(assigns(:story)).to eq(story2)
    end

    it "assigns @next_story" do
      expect(assigns(:next_story)).to eq(story3)
    end

    it "assigns @prev_story" do
      expect(assigns(:prev_story)).to eq(story1)
    end
  end

  describe 'GET #new' do
    it 'assigns a new story to @story' do
      get :new
      expect(assigns(:story)).to be_a_new(Story)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { stories: [Rack::Test::UploadedFile.new('spec/fixtures/files/vid.mp4')] } }
    let(:invalid_attributes) { { stories: nil } }

    context 'with valid attributes' do
      it 'creates a new story' do
        expect {
          post :create, params: { story: valid_attributes }
        }.to change(Story, :count).by(1)
      end

      it 'redirects to homes_path' do
        post :create, params: { story: valid_attributes }
        expect(response).to redirect_to(homes_path)
      end

      it 'sets a notice flash message' do
        post :create, params: { story: valid_attributes }
        expect(flash[:notice]).to eq('story was successfully created.')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the story' do
      story # Create the story before running the test
      expect {
        delete :destroy, params: { id: story.id }
      }.to change(Story, :count).by(-1)
    end

    it 'redirects to homes_path' do
      delete :destroy, params: { id: story.id }
      expect(response).to redirect_to(homes_path)
    end
  end
end
