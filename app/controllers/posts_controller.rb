class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:confirm_new, :create, :destroy]
  before_action :correct_user, only: [:confirm_new, :create, :update, :destroy]

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
    @open_posts = Post.where(status: true).order(id: :desc).page(params[:page])

    if params[:back].present?
      render 'toppages/show'
      return
    end

    f = PostsHelper.build(@post.content).tempfile.open
    # f = File.open(Rails.root.join("app/assets/images/default.png"))
    @post.image.attach(io: f, filename: 'default.png')

    if @post.save
      flash[:success] = '質問を投稿しました。'
      client = User.set_twitter_client(current_user)
      text = "situmon\n#q #a\n#{request.base_url}/users/#{current_user.nickname}/posts/#{@post.id}"
      client.update(text)
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:danger] = '質問の投稿に失敗しました。'
      render 'toppages/show'
    end
  end

  def update
    @post = Post.find(params[:id])
    @user = @post.user
    @post.status = !@post.status
    @post.save
    if @post.status
      flash[:success] = '回答を受け付けました'
    else
      flash[:success] = '回答を締め切りました'
    end
    redirect_to user_url(@user)
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.user
    @post.destroy
    flash[:success] = '質問を削除しました。'
    redirect_to user_url(@user)
  end

  def get_image
    @image = Post.find(params[:id]).image
    send_data(@image, disposition: "inline", type: "image/jpeg")
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def correct_user
    @user = User.find_by!(nickname: params[:user_nickname])
    if @user != current_user
      redirect_to toppages_show_url
      flash[:danger] = '権限がありません。'
    end
  end
end
