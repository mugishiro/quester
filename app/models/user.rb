class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable,
         :validatable, :omniauthable, omniauth_providers: [:twitter]
  has_many :posts, dependent: :destroy

  def to_param
    nickname
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first_or_initialize
    # Twitterはemailを返さないことが多く、空文字の既存レコードだとpresenceバリデーションに失敗するため上書きする
    user.email = User.dummy_email(auth) if user.email.blank?
    user.username = auth.info.name if auth.info.name.present?
    user.nickname = auth.info.nickname if auth.info.nickname.present?
    user.image_url = auth.info.image if auth.info.image.present?
    user.description = auth.info.description if auth.info.description.present?
    user.password = Devise.friendly_token[0, 20] if user.encrypted_password.blank?
    user.access_token = auth.credentials.token
    user.access_secret = auth.credentials.secret
    user.save!
    user.refresh_profile_from_twitter!(auth_info: auth.info)
    user
  end

  def registered_following_users
    client = User.set_twitter_client(self)
    uid_array = client.friend_ids.attrs[:ids]
    User.where(uid: uid_array)
  rescue Twitter::Error => e
    Rails.logger.warn("Unable to fetch friends from Twitter: #{e.class} #{e.message}")
    []
  end

  def self.set_twitter_client(user)
    twitter_credentials = Rails.application.credentials[:twitter] || {}
    consumer_key = ENV['TWITTER_CONSUMER_KEY'] || twitter_credentials[:consumer_key]
    consumer_secret = ENV['TWITTER_CONSUMER_SECRET'] || twitter_credentials[:consumer_secret]
    unless consumer_key.present? && consumer_secret.present?
      raise "Twitter API credentials are not configured"
    end
    Twitter::REST::Client.new do |config|
      config.consumer_key = consumer_key
      config.consumer_secret = consumer_secret
      config.access_token = user.access_token
      config.access_token_secret = user.access_secret
    end
  end

  def url
    "https://twitter.com/#{nickname}"
  end

  def refresh_profile_from_twitter!(auth_info: nil)
    updated = false

    if auth_info
      if auth_info.name.present? && auth_info.name != username
        self.username = auth_info.name
        updated = true
      end
      if auth_info.nickname.present? && auth_info.nickname != nickname
        self.nickname = auth_info.nickname
        updated = true
      end
      if auth_info.image.present? && auth_info.image != image_url
        self.image_url = auth_info.image
        updated = true
      end
      if auth_info.description.present? && auth_info.description != description
        self.description = auth_info.description
        updated = true
      end
    end

    if access_token.present? && access_secret.present?
      begin
        client = User.set_twitter_client(self)
        profile = client.user(uid)
        if profile
          if profile.name.present? && profile.name != username
            self.username = profile.name
            updated = true
          end
          if profile.screen_name.present? && profile.screen_name != nickname
            self.nickname = profile.screen_name
            updated = true
          end
          avatar = profile.respond_to?(:profile_image_url_https) ? profile.profile_image_url_https.to_s : profile.profile_image_url.to_s
          if avatar.present? && avatar != image_url
            self.image_url = avatar
            updated = true
          end
          if profile.description.present? && profile.description != description
            self.description = profile.description
            updated = true
          end
        end
      rescue Twitter::Error => e
        Rails.logger.warn("Failed to refresh profile from Twitter: #{e.class} #{e.message}")
      end
    end

    save! if updated
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
