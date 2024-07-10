require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/post/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    def create_post(title , body)
      post post_index_path, params:{
        post:{
          title: title,
          body: body
        }
      }
    end

    context "with valid params" do
      it "creates a new Post and redirects" do
        expect do
          create_post("uyu" , "ghj")
        end.to change { Post.count }.from(0).to(1)
        
        expect(response).to have_http_status(:redirect)
      end
    end

    context "with invalid params" do
      it "does not create a new Post and re-renders the new template" do
        expect do
          create_post("" , "")
        end.not_to change { Post.count }
        
        expect(Post.count).to eq(0)
        expect(response).to have_http_status(:success)
      end
    end
  end
end