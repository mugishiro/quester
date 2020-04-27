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
    before do
      get user_path user.nickname
    end

    it "responds successfully" do
      expect(response.status).to eq 200
    end

    it "has only open_post" do
      expect(response.body).to include "openpost"
      expect(response.body).to_not include "closedpost"
    end
  end

  describe "GET #closed" do
    before do
      get closed_posts_path user.nickname
    end

    it "responds successfully" do
      expect(response.status).to eq 200
    end

    it "has only closed_post" do
      expect(response.body).to include "closedpost"
      expect(response.body).to_not include "openpost"
    end
  end
end
