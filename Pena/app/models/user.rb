class User < ActiveRecord::Base

    def self.from_omniauth(auth)
      Rails.logger.info auth.to_yaml
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.access_token = auth.credentials.token
      user.name = auth.info.name
      user.image_url = auth.info.image
      user.email = auth.extra.raw_info.emailAddress
      user.headline = auth.extra.raw_info.headline
      user.industry = auth.extra.raw_info.industry
      user.save!
      user
      end
    end



    def company
      api = LinkedIn::API.new(access_token)
      company_hash = api.profile(fields:["id", {"positions" => ["company" => ["name"]]}])
      company_name = company_hash.positions.all[0].company.name
      company_name
    end

    def title
      api = LinkedIn::API.new(access_token)
      title_hash = api.profile(fields:["id", {"positions" => ["title"]}])
      title = title_hash.positions.all[0].title
      title
    end
end
