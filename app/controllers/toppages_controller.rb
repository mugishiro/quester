class ToppagesController < ApplicationController
  before_action :set_twitter_client, only: [:show, :follows]

  def index
  end

  # def show
  #   @friends = @client.friends(current_user).take(20)
  #   @timeline = @client.home_timeline.take(20)
  # end

  def show
    @post = current_user.posts.build
    @posts = current_user.posts.order(id: :desc).page(params[:page])
  end

  def follows
    @friends = current_user.registered_following_users
    # @friends = @client.friends(current_user).take(20)
  end

  private
    def set_twitter_client
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV["CONSUMER_KEY"]
        config.consumer_secret = ENV["CONSUMER_SECRET"]
        config.access_token = current_user.access_token
        config.access_token_secret = current_user.access_secret
      end
    end
end
