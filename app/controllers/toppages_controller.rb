class ToppagesController < ApplicationController
  before_action :set_twitter_client, only: [:show, :post]
  
  def index
  end
  
  def show
    @friends = @client.friends(current_user).take(20)
    @timeline = @client.home_timeline.take(20)
  end

  # def post
  #   @client.update("テスＬ")
  #   redirect_to root_path
  # end

  private
    def set_twitter_client
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = "PIT0rvhv3iyU9BcWDV6IBwK5R"
        config.consumer_secret = "iTVqiEZ6np9mmmit57u91bG3mtNBrqMrkqQ5Ks6yZDn0OOFbbz"
        config.access_token = current_user.access_token
        config.access_token_secret = current_user.access_secret
      end
    end
end
