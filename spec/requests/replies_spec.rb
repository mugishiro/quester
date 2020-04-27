require 'rails_helper'

RSpec.describe "Replies", type: :request do
  let!(:reply) { create(:reply, content: "test reply") }

  describe "GET #confirm_new" do
    context "with valid attributes" do
      before do
        post confirm_new_reply_path, params: { reply: reply.attributes }
      end

      it "responds successfully" do
        expect(response.status).to eq 200
      end

      it "has @reply" do
        expect(response.body).to include "test reply"
      end
    end

    context "when post is closed" do
      it "does not reply and redirect to the toppage" do
        reply.post.update_attribute(:status, false)
        post confirm_new_reply_path, params: { reply: reply.attributes }
        expect(response.status).to eq 302
        expect(response).to redirect_to toppages_show_url
      end
    end
  end

  describe "GET #create" do
    context "with valid attributes" do
      it "adds a reply" do
        expect do
          post replies_path, params: { reply: reply.attributes }
        end.to change(Reply, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not add a reply" do
        reply.update_attribute(:content, nil)
        expect do
          post replies_path, params: { reply: reply.attributes }
        end.not_to change(Reply, :count)
      end
    end

    context "when post is closed" do
      it "does not reply" do
        reply.post.update_attribute(:status, false)
        post replies_path, params: { reply: reply.attributes }
        expect(response.status).to eq 302
        expect(response).to redirect_to toppages_show_url
      end
    end
  end
end
