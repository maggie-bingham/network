class User < ActiveRecord::Base

    def self.from_omniauth(auth)
      Rails.logger.info auth.to_yaml
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.access_token = auth.credentials.token
      user.name = auth.info.name
      user.image_url = auth.info.image
      user.email = auth.extra.raw_info.emailAddress
      user.industry = auth.extra.raw_info.industry
      user.headline = auth.extra.raw_info.headline
      user.save!
      user
      end
    end



    def linkedin_profile
      api = LinkedIn::API.new(access_token)
      api.profile
    end

end
