class User < ActiveRecord::Base

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.access_token = auth.credentials.token
      user.name = auth.info.name
      user.image_url = auth.info.image
      user.email = auth.extra.raw_info.emailAndress
      user.industy = auth.extra.raw_info.industy
      user.headline = auth.extra.raw_info.headline
      user.save!
      user
      end
    end

    # def linkedin_company
    #   api = LinkedIn::API.new(access_token)
    #   company_hash = api.profile(fields:["id", {"positions" => ["company" => ["name"]]}])
    #   company_name = company_hash.positions.all[0].company.name
    #   company_name
    # end
    #
    # def linkedin_title
    #   api = LinkedIn::API.new(access_token)
    #   title_hash = api.profile(fields:["id", {"positions" => ["title"]}])
    #   work_title = title_hash.positions.all[0].title
    #   work_title
    # end

end
