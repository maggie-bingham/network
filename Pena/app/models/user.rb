class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  def from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.image_url = auth_hash['info']['image']
    user.headline = auth_hash['info']['headline']
    user.industry = auth_hash['info']['industry']
    user.url = get_url_for user.provider, auth_hash['info']['urls']
    user.save!
    user
  end

  private

  def get_url_for(provider, urls_hash)
    case provider
      when 'linkedin'
        urls_hash['public_profile']
      else
        urls_hash[provider.capitalize]
    end
  end

end
