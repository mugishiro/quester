class ToppagesController < ApplicationController
  before_action :require_user_logged_in

  def show
    @post = current_user.posts.build
    @posts = current_user.posts.order(id: :desc).page(params[:page])
  end

  def follows
    @friends = current_user.registered_following_users
  end
end
