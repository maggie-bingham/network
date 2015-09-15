class User < ActiveRecord::Base
  acts_as_mappable :default_units => :miles,
                                    :default_formula => :sphere,
                                    :distance_field_name => :distance,
                                    :lat_column_name => :lat,
                                    :lng_column_name => :lon

  has_many :notes
  has_many :authored_notes, :class_name => "Note", :foreign_key => "author_id"

  acts_as_followable
  acts_as_follower

  has_and_belongs_to_many :events
  has_many :event_members, :as => :invitable
  has_many :events, :through => :event_members, :source => :attendable, :source_type => "Event"

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

    def notes_for_user(user)
      authored_notes.where(user: user)
    end



end
