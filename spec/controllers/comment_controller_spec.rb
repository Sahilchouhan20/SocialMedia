require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:post) { create(:post) }
  let(:comment) { create(:comment, post: post, user: user) }
  let(:user) { create(:user) } # If you are using user authentication

  before do
    sign_in user # If you're using Devise or any authentication gem
  end

  describe 'GET #index' do
    it 'assigns @comments and renders the index template' do
      get :index, params: { post_id: post.id }
      expect(assigns(:comments)).to eq(post.comments)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new comment to @comment and renders the new template' do
      get :new, params: { post_id: post.id }
      expect(assigns(:comment)).to be_a_new(Comment)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new comment and redirects to the post' do
        expect {
          process :create, method: :post, params: { post_id: post.id, comment: attributes_for(:comment, user_id: user.id, discription: "discription") }
        }.to change(Comment, :count).by(1)
        expect(response).to redirect_to(post_path(post))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new comment and re-renders the new template' do
        expect {
          process :create, method: :post, params: { post_id: post.id, user_id: user.id, comment: attributes_for(:comment, discription: '') }
        }.not_to change(Comment, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested comment to @comment and renders the edit template' do
      get :edit, params: { post_id: post.id, id: comment.id, user_id: user.id }
      expect(assigns(:comment)).to eq(comment)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the comment and redirects to the post' do
        patch :update, params: { post_id: post.id, id: comment.id, comment: { discription: 'Updated description' } }
        comment.reload
        expect(comment.discription).to eq('Updated description')
        expect(response).to redirect_to(post_path(post))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the comment and re-renders the edit template' do
        patch :update, params: { post_id: post.id, id: comment.id, comment: { discription: '' } }
        comment.reload
        expect(comment.discription).to_not eq('')
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post) }
    let!(:comment) { create(:comment, post: post) }

    it 'deletes the comment and redirects to the post' do
      expect {
        delete :destroy, params: { post_id: post.id, id: comment.id }
      }.to change(Comment, :count).by(-1)  # Expect the count to decrease by 1

      expect(response).to redirect_to(post_path(post))  # Expect a redirect to the post
    end
  end
end
