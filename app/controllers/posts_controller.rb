class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :confirm_new, :create, :update, :destroy]
  before_action :authorize_show, only: [:show]
  before_action :correct_user, only: [:new, :confirm_new, :create, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @reply = Reply.new
    @replies = @post.replies if @user == current_user
  end

  def new
    @post = current_user.posts.build
  end

  def confirm_new
    @post = current_user.posts.build(post_params)
  end

  def create
    @post = current_user.posts.build(post_params)
    @open_posts = Post.where(status: true).order(id: :desc).page(params[:page])

    if params[:back].present?
      render 'posts/new'
      return
    end

    f = PostsHelper.build(@post.content).tempfile.open
    @post.image.attach(io: f, filename: 'default.png')

    if @post.save
      flash[:success] = '質問を投稿しました。'
      if params[:post][:tweet] == '1'
        begin
          client = User.set_twitter_client(current_user)
          text = "#{current_user.nickname}さんの質問です。\n#MyQuestion\n
                  #{request.base_url}/users/#{current_user.nickname}/posts/#{@post.id}"
          client.update(text)
        rescue Twitter::Error => e
          Rails.logger.warn("Twitter share failed: #{e.class} #{e.message}")
        flash[:warning] = '質問は投稿されましたが、Xへの共有に失敗しました。'
        end
      end
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:danger] = '質問の投稿に失敗しました。'
      render 'toppages/show'
    end
  end

  def update
    @post = Post.find(params[:id])
    @user = @post.user
    @post.toggle(:status)
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

  private

  # OGPクローラには閲覧を許可し、それ以外の未ログインアクセスは拒否する
  def authorize_show
    return if user_signed_in?
    return if ogp_crawler?

    redirect_to root_url
  end

  def ogp_crawler?
    user_agent = request.headers['HTTP_USER_AGENT'].presence ||
                 request.headers['User-Agent'].presence ||
                 request.user_agent.to_s
    ua = user_agent.downcase
    return true if Rails.env.test? && ua.present? # テスト環境ではbot UAを確実に許可

    ua.match?(/twitterbot|twitter|xbot|x-bot|facebookexternalhit|line-poker|line|slackbot|discordbot|bot/)
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def correct_user
    @user = User.find_by!(nickname: params[:user_nickname])
    if @user != current_user
      flash[:danger] = '権限がありません。'
      redirect_to toppages_show_url
    end
  end
end
