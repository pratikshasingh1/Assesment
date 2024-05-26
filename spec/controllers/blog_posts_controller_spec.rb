require 'rails_helper'

RSpec.describe BlogPostsController, type: :controller do
	let(:user) { create(:user) }
  let(:blog_post) { create(:blog_post, user: user) }
  let(:valid_attributes) { { title: 'Valid Title', content: 'Valid Content' } }
  let(:invalid_attributes) { { title: '', content: '' } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all blog posts as @blog_posts' do
      blog_post = BlogPost.create! valid_attributes
      get :index
      expect(assigns(:blog_posts)).to eq([blog_post])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: blog_post.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new BlogPost' do
        expect {
          post :create, params: { blog_post: valid_attributes }
        }.to change(BlogPost, :count).by(1)
      end

      it 'redirects to the created blog post' do
        post :create, params: { blog_post: valid_attributes }
        expect(response).to redirect_to(BlogPost.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new BlogPost' do
        expect {
          post :create, params: { blog_post: invalid_attributes }
        }.to change(BlogPost, :count).by(0)
      end

      it 'renders the new template' do
        post :create, params: { blog_post: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: blog_post.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) { { title: 'New Title', content: 'New Content' } }

      it 'updates the requested blog post' do
        patch :update, params: { id: blog_post.to_param, blog_post: new_attributes }
        blog_post.reload
        expect(blog_post.title).to eq('New Title')
        expect(blog_post.content).to eq('New Content')
      end

      it 'redirects to the blog post' do
        patch :update, params: { id: blog_post.to_param, blog_post: new_attributes }
        expect(response).to redirect_to(blog_post)
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        patch :update, params: { id: blog_post.to_param, blog_post: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested blog post' do
      blog_post = BlogPost.create! valid_attributes
      expect {
        delete :destroy, params: { id: blog_post.to_param }
      }.to change(BlogPost, :count).by(-1)
    end

    it 'redirects to the blog posts list' do
      delete :destroy, params: { id: blog_post.to_param }
      expect(response).to redirect_to(blog_posts_url)
    end
  end

  describe 'authentication' do
    before do
      sign_out user
    end

    it 'redirects to the login page for new action' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'redirects to the login page for create action' do
      post :create, params: { blog_post: valid_attributes }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'redirects to the login page for edit action' do
      get :edit, params: { id: blog_post.to_param }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'redirects to the login page for update action' do
      patch :update, params: { id: blog_post.to_param, blog_post: valid_attributes }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'redirects to the login page for destroy action' do
      delete :destroy, params: { id: blog_post.to_param }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
