class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @reply = Reply.new
    @replies = @post.replies if @user == current_user
  end

  def new
  end

  def confirm_new
    @post = current_user.posts.build(post_params)
  end

  def create
    @post = current_user.posts.build(post_params)
    @posts = current_user.posts.order(id: :desc).page(params[:page])

    if params[:back].present?
      render 'toppages/show'
      return
    end

    if @post.save
      flash[:success] = '質問を投稿しました。'
      redirect_to toppages_show_path
    else
      flash.now[:danger] = '質問の投稿に失敗しました。'
      render 'toppages/show'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.user
    @post.destroy
    redirect_to user_url(@user), notice: "質問を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
