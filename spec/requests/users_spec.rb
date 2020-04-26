require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "login" do
    before do
    end

    it "works! (now write some real specs)" do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        "uid" => "123",
        "provider" => "twitter",
        "info" => {
          "nickname" => "anonymous"
        }
      })
      @oauth_user = OmniAuth.config.mock_auth[:twitter]
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      post user_twitter_omniauth_authorize_path
      get root_path
    end
  end
end
