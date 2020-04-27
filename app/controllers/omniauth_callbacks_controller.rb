class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_from :twitter
  end

  def after_sign_in_path_for(resource)
    toppages_show_path
  end

  private

  def callback_from(provider)
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:success] = "ログインしました。"
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_registration_url
    end
  end
end
