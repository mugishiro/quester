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
    user.email ||= User.dummy_email(auth)
    user.username = auth.info.name if auth.info.name.present?
    user.nickname = auth.info.nickname if auth.info.nickname.present?
    user.image_url = auth.info.image if auth.info.image.present?
    user.description = auth.info.description if auth.info.description.present?
    user.password = Devise.friendly_token[0, 20] if user.encrypted_password.blank?
    user.access_token = auth.credentials.token
    user.access_secret = auth.credentials.secret
    user.save!
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

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
