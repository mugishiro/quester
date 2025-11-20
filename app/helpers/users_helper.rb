module UsersHelper
  def avatar_url(user)
    user&.image_url.presence || "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"
  end

  def safe_description(user)
    user&.description.presence || " "
  end
end
