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

   private

   def self.dummy_email(auth)
     "#{auth.uid}-#{auth.provider}@example.com"
   end
end
