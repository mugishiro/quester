class RepliesController < ApplicationController
  def create
    @post = Post.find(reply_params[:post_id])
    @reply = @post.replies.build(reply_params)
    if @reply.save
      flash[:success] = '回答を投稿しました。'
      redirect_to post_path(@post)
    else
      @reply = @post.replies.order(id: :desc).page(params[:page])
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
