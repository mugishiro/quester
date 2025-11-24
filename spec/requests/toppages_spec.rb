require 'rails_helper'

RSpec.describe "Toppages", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:open_post) do
    create(:post, content: "openpost", user: user)
  end
  let!(:other_open_post) do
    create(:post, content: "other user question", user: other_user)
  end
  let!(:closed_post) do
    create(:post, status: false, content: "closedpost", user: user)
  end

  describe "GET #index" do
    it "responds successfully" do
      get root_path
      expect(response.status).to eq 200
    end

    context "as an authenticated user" do
      it "shows only others' open posts" do
        sign_in user
        get root_path
        expect(response.body).to include "other openpost"
        expect(response.body).not_to include "openpost"
        expect(response.body).not_to include "closedpost"
      end
    end
  end

  describe "GET #show" do
    context "as an authenticated user" do
      before do
        sign_in user
        get toppages_show_path
      end

      it "responds successfully" do
        expect(response.status).to eq 200
      end

      it "has only others' open posts" do
        expect(response.body).to include "other openpost"
        expect(response.body).not_to include "openpost"
        expect(response.body).not_to include "closedpost"
      end
    end

    context "as a guest" do
      it "redirects to the root_url" do
        get toppages_show_path
        expect(response.status).to eq 302
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #follows" do
    context "as a guest" do
      it "redirects to the root_url" do
        get toppages_follows_path
        expect(response.status).to eq 302
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #edit" do
    context "as an authenticated user" do
      it "responds successfully" do
        sign_in user
        get toppages_edit_path
        expect(response.status).to eq 200
      end
    end

    context "as a guest" do
      it "redirects to the root_url" do
        get toppages_edit_path
        expect(response.status).to eq 302
        expect(response).to redirect_to root_url
      end
    end
  end
end
