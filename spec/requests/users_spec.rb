require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let!(:open_post) do
    create(:post, content: "openpost", user: user)
  end
  let!(:closed_post) do
    create(:post, status: false, content: "closedpost", user: user)
  end

  describe "GET #show" do
    context "as an authorized user" do
      before do
        sign_in user
        get user_path user.nickname
      end

      it "responds successfully" do
        expect(response.status).to eq 200
      end

      it "has only open_post" do
        expect(response.body).to include "openpost"
        expect(response.body).not_to include "closedpost"
      end
    end

    context "as a guest" do
      it "redirects to the root_url" do
        get user_path user.nickname
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #closed" do
    context "as an authorized user" do
      before do
        sign_in user
        get closed_posts_path user.nickname
      end

      it "responds successfully" do
        expect(response.status).to eq 200
      end

      it "has only closed_post" do
        expect(response.body).to include "closedpost"
        expect(response.body).not_to include "openpost"
      end
    end

    context "as a guest" do
      it "redirects to the root_url" do
        get closed_posts_path user.nickname
        expect(response).to redirect_to root_url
      end
    end
  end
end
