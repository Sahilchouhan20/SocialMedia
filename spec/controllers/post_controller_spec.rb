# spec/controllers/posts_controller_spec.rb
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }
  let(:valid_attributes) { { text: 'Valid text', images: [fixture_file_upload('spec/fixtures/files/image.png')] } }
  let(:invalid_attributes) { { text: '' } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all posts to @posts' do
      get :index
      expect(assigns(:posts)).to include(post)
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    context 'when the post belongs to the current user' do
      it 'assigns the requested post to @post' do
        get :show, params: { id: post.id }
        expect(assigns(:post)).to eq(post)
      end

      it 'renders the :show template' do
        get :show, params: { id: post.id }
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #new' do
    it 'assigns a new post to @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new post' do
        expect {
          post :create, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it 'redirects to the new post' do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to(Post.last)
      end

      it 'sets a flash notice' do
        post :create, params: { post: valid_attributes }
        expect(flash[:notice]).to eq('Post was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new post' do
        expect {
          post :create, params: { post: invalid_attributes }
        }.to change(Post, :count).by(0)
      end

      it 'renders the :new template' do
        post :create, params: { post: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let(:post) { create(:post, user: user) }

    context 'with invalid attributes' do
      it 'does not update the post' do
        patch :update, params: { id: post.id, post: invalid_attributes }
        post.reload
        expect(post.text).not_to be_empty
      end

      it 'renders the :edit template' do
        patch :update, params: { id: post.id, post: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post_to_delete) { create(:post, user: user) }

    it 'deletes the post' do
      expect {
        delete :destroy, params: { id: post_to_delete.id }
      }.to change(Post, :count).by(-1)
    end
  end
end
