class User < ApplicationRecord
   # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [:twitter]
   has_many :posts

   def self.find_for_oauth(auth)
     user = User.where(uid: auth.uid, provider: auth.provider).first
     unless user
       user = User.create(
         uid:      auth.uid,
         provider: auth.provider,
         email:    User.dummy_email(auth),
         username: auth.info.name,
         nickname: auth.info.nickname,
         image_url: auth.info.image,
         description: auth.info.description,
         password: Devise.friendly_token[0, 20],
         access_token: auth.credentials.token,
         access_secret: auth.credentials.secret
       )
     end
     user
   end

   def registered_following_users
     client = set_twitter_client
     uid_array = client.friend_ids.attrs[:ids]
     User.where(uid: uid_array)
   end

   def set_twitter_client
     Twitter::REST::Client.new do |config|
       config.consumer_key = ENV["CONSUMER_KEY"]
       config.consumer_secret = ENV["CONSUMER_SECRET"]
       config.access_token = access_token
       config.access_token_secret = access_secret
     end
   end

   private

   def self.dummy_email(auth)
     "#{auth.uid}-#{auth.provider}@example.com"
   end
end
