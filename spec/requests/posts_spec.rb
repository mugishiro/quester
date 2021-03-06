require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:test_post) { create(:post, content: "test post", user: user) }

  describe "GET #show" do
    it "responds successfully" do
      get user_post_path user.nickname, test_post.id
      expect(response.status).to eq 200
    end
  end

  describe "POST #confirm_new" do
    context "as an authorized user" do
      before do
        sign_in user
        post confirm_new_user_post_path user.nickname, params: { post: test_post.attributes }
      end

      it "responds successfully" do
        expect(response.status).to eq 200
      end

      it "has @post" do
        expect(response.body).to include "test post"
      end
    end

    context "as an unauthorized user" do
      it "does not post and redirects to the toppage" do
        sign_in other_user
        post confirm_new_user_post_path user.nickname, params: { post: test_post.attributes }
        expect(response.status).to eq 302
        expect(response).to redirect_to toppages_show_url
      end
    end

    context "as a guest" do
      it "redirects to the root_url" do
        post confirm_new_user_post_path user.nickname, params: { post: test_post.attributes }
        expect(response.status).to eq 302
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "POST #create" do
    context "as an authorized user" do
      before do
        sign_in user
        post user_posts_path user.nickname, params: { post: test_post.attributes }
      end

      context "with valid attributes" do
        it "adds a post" do
          expect do
            post user_posts_path user.nickname, params: { post: test_post.attributes }
          end.to change(Post, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not add a post" do
          test_post.update_attribute(:content, nil)
          expect do
            post user_posts_path user.nickname, params: { post: test_post.attributes }
          end.not_to change(Post, :count)
        end
      end
    end

    context "as an unauthorized user" do
      it "does not post and redirects to the toppage" do
        sign_in other_user
        post user_posts_path user.nickname, params: { post: test_post.attributes }
        expect(response.status).to eq 302
        expect(response).to redirect_to toppages_show_url
      end
    end

    context "as a guest" do
      it "redirects to the root_url" do
        post confirm_new_user_post_path user.nickname, params: { post: test_post.attributes }
        expect(response.status).to eq 302
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "POST #update" do
    context "as an authorized user" do
      it "toggles the post status" do
        sign_in user
        patch user_post_path user.nickname, test_post.id
        expect(test_post.reload.status).to eq false
        patch user_post_path user.nickname, test_post.id
        expect(test_post.reload.status).to eq true
      end
    end

    context "as an unauthorized user" do
      it "redirects to the toppage" do
        sign_in other_user
        patch user_post_path user.nickname, test_post.id
        expect(response.status).to eq 302
        expect(response).to redirect_to toppages_show_url
      end
    end

    context "as a guest" do
      it "redirects to the root_url" do
        patch user_post_path user.nickname, test_post.id
        expect(response.status).to eq 302
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "DELETE #destrory" do
    context "as an authorized user" do
      it "deletes the post" do
        sign_in user
        expect do
          delete user_post_path user.nickname, test_post.id
        end.to change(Post, :count).by(-1)
      end
    end

    context "as an unauthorized user" do
      it "redirects to the toppage" do
        sign_in other_user
        delete user_post_path user.nickname, test_post.id
        expect(response.status).to eq 302
        expect(response).to redirect_to toppages_show_url
      end
    end

    context "as a guest" do
      it "redirects to the root_url" do
        delete user_post_path user.nickname, test_post.id
        expect(response.status).to eq 302
        expect(response).to redirect_to root_url
      end
    end
  end
end
