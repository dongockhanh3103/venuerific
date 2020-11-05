require 'rails_helper'
require_relative '../support/devise'

describe PostsController, type: :controller do
  describe 'GET /' do
    context 'from login user' do
      let!(:post_sample) { create(:post) }
      login_user

      it 'list post will return with status 200' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'form new post will return with status 200' do
        get :new
        expect(response).to have_http_status(:success)
      end

      it 'search page will return with status 200' do
        get :search
        expect(response).to have_http_status(:success)
      end

      it 'create post successfully' do
        post :create, params: { post: { title: 'Morning' } }
        created_post = Post.find_by(title: 'Morning')

        expect(created_post.id).to eq(Post.last.id)
        # It will redirect to home page
        expect(response).to have_http_status(302)
      end

      it 'show a post successfully' do
        get :show, params: { id: post_sample.id }

        expect(response).to have_http_status(200)
      end

      it 'redirect to 404 page if post not found successfully' do
        get :show, params: { id: -1 }

        expect(response).to have_http_status(404)
      end
    end

    context 'from not login user' do
      it 'list post will return with status 200' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'form new post will return with status 302' do
        get :new
        expect(response).to have_http_status(302)
      end

      it 'search page will return with status 200' do
        get :search
        expect(response).to have_http_status(200)
      end

      it 'create post failure' do
        post :create, params: { post: { title: 'Morning' } }
        created_post = Post.find_by(title: 'Morning')

        expect(created_post.nil?).to eq(Post.last.nil?)
        # It will redirect to login page
        expect(response).to have_http_status(302)
      end

      let(:post_sample) { create(:post) }
      it 'destroy post failure' do
        delete :destroy, params: { id: post_sample.id }

        expect(Post.first.id).to eq(post_sample.id)
        # It will redirect to login page
        expect(response).to have_http_status(302)
      end

      it 'show a post successfully' do
        get :show, params: { id: post_sample.id }

        expect(response).to have_http_status(200)
      end
    end

    context 'from invalid user' do
      let!(:post_sample) { create(:post) }
      login_user

      it 'update action should return 403 status' do
        put :update, params: { id: post_sample.id, post: { title: 'Updated name' } }

        expect(response).to have_http_status(403)
      end

      it 'detroy action should return 403 status' do
        put :destroy, params: { id: post_sample.id }

        expect(response).to have_http_status(403)
      end

      it 'edit action should return 403 status' do
        get :edit, params: { id: post_sample.id }

        expect(response).to have_http_status(403)
      end
    end
  end
end
