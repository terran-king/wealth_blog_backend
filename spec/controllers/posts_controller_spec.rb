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
    context "with invalid params" do
      it "returns a failure response" do
        # post :create, params: {post: {title: nil, body: 'This should fails'}}
        # expect{response).to have_http_status(:unprocessable_entity)
        expect {
          post :create, params: {post: {title: nil, body: 'This should fails'}}
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end
end
