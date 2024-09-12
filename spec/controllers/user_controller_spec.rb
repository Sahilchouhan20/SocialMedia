# spec/controllers/users_controller_spec.rb
require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { create(:user) }

  before do
    sign_in user # Assumes Devise is used for authentication
  end

  describe 'GET #show' do
    context 'when the user exists' do
      it 'assigns the requested user to @user' do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the :show template' do
        get :show, params: { id: user.id }
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #edit' do
    context 'when the user exists' do
      it 'assigns the requested user to @user' do
        get :edit, params: { id: user.id  }
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the :edit template' do
        get :edit, params: { id: user.id }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the user' do
        patch :update, params: { id: user.id, user: { name: 'New Name' } }
        user.reload
        expect(user.name).to eq('New Name')
      end

      it 'redirects to the updated user' do
        patch :update, params: { id: user.id, user: { name: 'New Name' } }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user' do
        patch :update, params: { id: user.id, user: { name: '' } }
        user.reload
        expect(user.name).not_to eq('')
      end

      it 're-renders the :edit template' do
        patch :update, params: { id: user.id, user: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      delete :destroy, params: { id: user.id }
      expect(User.exists?(user.id)).to be_falsey
    end

    it 'redirects to the root path' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
