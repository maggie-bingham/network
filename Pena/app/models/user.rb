class User < ActiveRecord::Base

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.image_url = auth.info.image
      user.save!
      end
    end

    def client
      access_token = request_token.token
      access_token_secret = request_token.secret

      client = LinkedIn::Client.new
      client.authorize_from_access(access_token, access_token_secret)
      client
    end

    def linkedin_profile
    end







end
