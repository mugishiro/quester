class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @reply = Reply.new
    @replies = @post.replies if @user == current_user
  end

  def new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '質問を投稿しました。'
      redirect_to toppages_show_path
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '質問の投稿に失敗しました。'
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
