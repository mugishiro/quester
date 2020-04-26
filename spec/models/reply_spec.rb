require 'rails_helper'

RSpec.describe Reply, type: :model do
  let(:reply) { create(:reply) }

  it "is valid with a content" do
    expect(reply).to be_valid
  end

  describe "check content validation" do
    context "when content is nil" do
      it "is invalid" do
        reply.content = nil
        expect(reply).to_not be_valid
      end
    end
    context "when content is not too long" do
      it "is valid" do
        reply.content = "a" * 1000
        expect(reply).to be_valid
      end
    end
    context "when content is too long" do
      it "is invalid" do
        reply.content = "a" * 1001
        expect(reply).to_not be_valid
      end
    end
    context "when content is blank" do
      it "is invalid" do
        reply.content = " " * 300
        expect(reply).to_not be_valid
      end
    end
  end
end
