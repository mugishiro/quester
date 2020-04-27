require 'rails_helper'

RSpec.feature "Replies", type: :feature do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  describe "create a new reply" do
    before do
      visit user_post_path user.nickname, post.id
    end

    context "with valid attributes" do
      it "adds a reply" do
        fill_in "reply[content]", with: "test reply"
        click_button "commit"
        expect(current_path).to eq confirm_new_reply_path
        expect(page).to have_content "test reply"
        expect {
          click_button "commit"
        }.to change(post.replies, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't add a reply" do
        fill_in "reply[content]", with: "a" * 2000
        click_button "commit"
        expect(current_path).to eq confirm_new_reply_path
        expect(page).to have_content "a" * 2000
        expect {
          click_button "commit"
        }.to_not change(post.replies, :count)
      end
    end

    context "click cancel button" do
      it "doesn't add a post" do
        fill_in "reply[content]", with: "test reply"
        click_button "commit"
        expect(current_path).to eq confirm_new_reply_path
        expect(page).to have_content "test reply"
        expect {
          click_button "back"
        }.to_not change(post.replies, :count)
        expect(page).to have_content "test reply"
      end
    end
  end
end
