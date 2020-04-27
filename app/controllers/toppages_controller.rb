class ToppagesController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :follows, :edit]

  def index
    if user_signed_in?
      @post = current_user.posts.build
      @open_posts = Post.includes(:user).where(status: true).order(id: :desc).page(params[:page])
      render :action => "show"
    end
  end

  def show
    @post = current_user.posts.build
    @open_posts = Post.includes(:user).where(status: true).order(id: :desc).page(params[:page])
  end

  def follows
    @friends = current_user.registered_following_users
  end

  def edit
  end
end
