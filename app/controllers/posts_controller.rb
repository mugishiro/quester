class PostsController < ApplicationController
  before_action :require_user_logged_in

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to toppages_show_path
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/show'
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
