class RepliesController < ApplicationController
  def confirm_new
    @post = Post.find(reply_params[:post_id])
    @user = @post.user
    @reply = @post.replies.build(reply_params)
  end

  def create
    @post = Post.find(reply_params[:post_id])
    @user = @post.user
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

  def destroy
  end

  private

  def reply_params
    params.require(:reply).permit(:content, :post_id)
  end
end
