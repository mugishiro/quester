require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

  it "is valid with a content" do
    expect(post).to be_valid
  end

  describe "check content validation" do
    context "when content is nil" do
      it "is invalid" do
        post.content = nil
        expect(post).to_not be_valid
      end
    end
    context "when content is not too long" do
      it "is valid" do
        post.content = "a" * 1000
        expect(post).to be_valid
      end
    end
    context "when content is too long" do
      it "is invalid" do
        post.content = "a" * 1001
        expect(post).to_not be_valid
      end
    end
    context "when content is blank" do
      it "is invalid" do
        post.content = " " * 300
        expect(post).to_not be_valid
      end
    end
  end

  it "deletes replies if post is deleted" do
    reply = create(:reply)
    expect{ reply.post.destroy }.to change{ Reply.count }.by(-1)
  end
end
