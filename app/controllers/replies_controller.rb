class RepliesController < ApplicationController
  before_action :reply_only_opened_posts, only: [:confirm_new, :create]

  def confirm_new
    @post = Post.find(reply_params[:post_id])
    @user = @post.user
    @reply = @post.replies.build(reply_params)
  end

  def create
    @post = Post.find(reply_params[:post_id])
    @user = @post.user
    @replies = @post.replies if @user == current_user
    @reply = @post.replies.build(reply_params)

    if params[:back].present?
      render 'posts/show'
      return
    end

    if @reply.save
      flash[:success] = '回答を投稿しました。'
      redirect_to [@user, @post]
    else
      flash.now[:danger] = '回答の投稿に失敗しました。'
      render 'posts/show'
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:content, :post_id)
  end

  def reply_only_opened_posts
    @post = Post.find(reply_params[:post_id])
    if @post.status == false
      flash[:danger] = 'この質問は締め切られています。'
      redirect_to toppages_show_url
    end
  end
end
