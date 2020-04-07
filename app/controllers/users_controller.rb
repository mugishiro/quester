class UsersController < ApplicationController
  def show
    @user = User.find_by!(nickname: params[:nickname])
    @posts = @user.posts.order(id: :desc).page(params[:page])
  end
end
