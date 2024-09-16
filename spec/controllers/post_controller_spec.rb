require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:post, image: fixture_file_upload('spec/fixtures/files/image.png', 'image/png')) }
  let(:invalid_attributes) { {text: "Invalid"}}
  let(:post) { create(:post, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all posts with attached images to @posts" do
      post = create(:post, :with_image, user: user)
      get :index
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: post.to_param }
      expect(response).to be_successful
    end

    it "assigns the requested post to @post" do
      get :show, params: { id: post.to_param }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new post to @post" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST #create" do
    context "with valid params" do
       it "creates a new Post" do
        process :create, method: :post, params: { post: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(Post.count).to eq(1)
      end

      it "redirects to the created post" do
        process :create, method: :post, params: { post: valid_attributes }
        expect(response).to redirect_to(Post.last)
      end

      it "attaches the image to the post" do
        process :create, method: :post, params: { post: valid_attributes }
        expect(Post.last.images).to be_attached
      end

      it "sets a success notice" do
        process :create, method: :post, params: { post: valid_attributes }
        expect(flash[:notice]).to eq('Post was successfully created.')
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: post.to_param }
      expect(response).to be_successful
    end

    it "assigns the requested post to @post" do
      get :edit, params: { id: post.to_param }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { text: "Updated text" } }

      it "updates the requested post" do
        put :update, params: { id: post.to_param, post: new_attributes }
        post.reload
        expect(post.text).to eq("Updated text")
      end

      it "redirects to the post" do
        put :update, params: { id: post.to_param, post: new_attributes }
        expect(response).to redirect_to(post)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      post_to_delete = create(:post, user: user)
      expect {
        delete :destroy, params: { id: post_to_delete.to_param }
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the homes path" do
      delete :destroy, params: { id: post.to_param }
      expect(response).to redirect_to(homes_path)
    end
  end
end
