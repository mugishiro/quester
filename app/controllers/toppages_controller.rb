class ToppagesController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :follows, :edit]

  def index
    if user_signed_in?
      @post = current_user.posts.build
      @open_posts = Post.includes(:user).where(status: true).order(id: :desc).page(params[:page])
      render :action => "show"
    else
      render :index
    end
  end

  def show
    @post = current_user.posts.build
    @open_posts = Post.includes(:user).where(status: true).order(id: :desc).page(params[:page])
  end

  def follows
    flash[:alert] = "現在、友だち一覧はご利用いただけません。"
    redirect_to toppages_show_path
  end

  def edit
  end

  def guide
    render :index
  end
end
