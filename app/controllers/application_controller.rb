class ApplicationController < ActionController::Base
  private

  def require_user_logged_in
    unless user_signed_in?
      redirect_to root_url
    end
  end
end
