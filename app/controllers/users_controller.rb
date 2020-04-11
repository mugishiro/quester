class UsersController < ApplicationController
  def show
    @user = User.find_by!(nickname: params[:nickname])
    @open_posts = @user.posts.where(status: true).order(id: :desc).page(params[:page])
  end

  def closed
    @user = User.find_by!(nickname: params[:nickname])
    @closed_posts = @user.posts.where(status: false).order(id: :desc).page(params[:page])
  end
end
