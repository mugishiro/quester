require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  let(:user) { create(:user) }
  let(:post) { create(:post, content: "test post", user: user) }

  describe "user creates a new post" do
    before do
      sign_in user
      visit new_user_post_path(user.nickname)
    end

    context "with valid attributes" do
      it "adds a post" do
        fill_in "post[content]", with: "test post"
        click_button "commit"
        expect(current_path).to eq confirm_new_user_post_path user.nickname
        expect(page).to have_content "test post"
        expect do
          click_button "commit"
        end.to change(user.posts, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't add a post" do
        fill_in "post[content]", with: "a" * 2000
        click_button "commit"
        expect(current_path).to eq confirm_new_user_post_path user.nickname
        expect(page).to have_content "a" * 2000
        expect do
          click_button "commit"
        end.not_to change(user.posts, :count)
      end
    end

    context "click cancel button" do
      it "doesn't add a post" do
        fill_in "post[content]", with: "test post"
        click_button "commit"
        expect(current_path).to eq confirm_new_user_post_path user.nickname
        expect(page).to have_content "test post"
        expect do
          click_button "back"
        end.not_to change(user.posts, :count)
        expect(page).to have_content "質問する"
      end
    end
  end

  describe "user toggles a post status" do
    before do
      sign_in user
      visit user_post_path user.nickname, post.id
    end

    it "toggles status" do
      click_button "締め切る"
      expect(current_path).to eq user_path user.nickname
      expect(page).not_to have_content "test post"
      click_link "回答締め切り"
      expect(current_path).to eq closed_posts_path user.nickname
      expect(page).to have_content "test post"
      click_link "test post"
      expect(current_path).to eq user_post_path user.nickname, post.id
      click_button "回答を受け付ける"
      expect(current_path).to eq user_path user.nickname
      expect(page).to have_content "test post"
    end
  end

  describe "user deletes a post" do
    before do
      sign_in user
      visit user_post_path user.nickname, post.id
    end

    it "deletes a post" do
      click_link "削除する"
      expect(current_path).to eq user_path user.nickname
      expect(page).not_to have_content "test post"
    end
  end
end
