require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  let(:user) { create(:user) }

  describe "user creates a new post" do
    before do
      sign_in user
      visit toppages_show_path
    end

    context "with valid attributes" do
      it "adds a post" do
        fill_in "post[content]", with: "test post"
        click_button "commit"
        expect(current_path).to eq confirm_new_user_post_path user.nickname
        expect(page).to have_content "test post"
        expect {
          click_button "commit"
        }.to change(user.posts, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't add a post" do
        fill_in "post[content]", with: "a" * 2000
        click_button "commit"
        expect(current_path).to eq confirm_new_user_post_path user.nickname
        expect(page).to have_content "a" * 2000
        expect {
          click_button "commit"
        }.to_not change(user.posts, :count)
      end
    end

    context "click cancel button" do
      it "doesn't add a post" do
        fill_in "post[content]", with: "test post"
        click_button "commit"
        expect(current_path).to eq confirm_new_user_post_path user.nickname
        expect(page).to have_content "test post"
        expect {
          click_button "back"
        }.to_not change(user.posts, :count)
        expect(page).to have_content "test post"
      end
    end
  end
end
