require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      FactoryBot.create_list(:post, 3)
      get :index
      expect(response).to be_successful # or `expect(response).to have_http_status(200)`
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      post = FactoryBot.create(:post)
      get :show, params: {id: post.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect{
          post :create, params: {post: FactoryBot.attributes_for(:post)}
        }.to change(Post, :count).by(1)
      end
    end

    context "with invalid title" do
      it "returns a failure response" do
        # expect {
        #   post :create, params: {post: {title: nil, body: 'This should fails'}}
        # }.to have_http_status(:unprocessable_entity)
        post :create, params: {post: {title: nil, body: 'This should fail'}}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid body" do
      it "returns a failure response" do
        post :create, params: {post: {title: "This should fail", body: nil}}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #delete" do
    context "with valid params" do
      let!(:blog_post) { create(:post)}

      it "delete an existing Post" do
        expect{
          post :destroy, params: {id: blog_post.id}
        }.to change(Post, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "where doesn't exist" do
      it "returns a failure response" do
        # expect {
        #   post :create, params: {post: {title: nil, body: 'This should fails'}}
        # }.to have_http_status(:unprocessable_entity)
        post :create, params: {post: {title: nil, body: 'This should fail'}}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let!(:blog_post) { create(:post)}

      let(:valid_params) { {id:blog_post.id, post: { title: 'Update Title', body: 'Update Body'}}}

      it "update an existing Post" do
        put :update, params: valid_params
        blog_post.reload

        expect(blog_post.title).to match('Update Title')
        expect(blog_post.body).to match('Update Body')
        expect(response).to have_http_status(:ok)
      end
    end

    context "with valid title params" do
      let!(:blog_post) { create(:post)}

      let(:valid_params) { {id:blog_post.id, post: { title: 'Update Title'}}}

      it "update an existing Post" do
        put :update, params: valid_params
        blog_post.reload

        expect(blog_post.title).to match('Update Title')
        expect(blog_post.body).to match('Sample post content.')
        expect(response).to have_http_status(:ok)
      end
    end

    context "with valid body params" do
      let!(:blog_post) { create(:post)}

      let(:valid_params) { {id:blog_post.id, post: { body: 'Update Body'}}}

      it "update an existing Post" do
        put :update, params: valid_params
        blog_post.reload

        expect(blog_post.title).to match('Sample Post Title')
        expect(blog_post.body).to match('Update Body')
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
