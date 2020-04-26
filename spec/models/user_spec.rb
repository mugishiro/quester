require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "is valid with a uid, email, provider, username and password" do
    expect(user).to be_valid
  end

  it "is invalid without an email address" do
    user.email = nil
    expect(user).to_not be_valid
  end

  it "is invalid without an email address" do
    user = build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it "deletes posts if user is deleted" do
    post = create(:post)
    expect{ post.user.destroy }.to change{ Post.count }.by(-1)
  end
end
