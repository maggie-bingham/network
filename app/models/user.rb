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
      user = User.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
      user.access_token = auth.credentials.token
      user.name = auth.info.name
      user.image_url = auth.info.image
      user.email = auth.extra.raw_info.emailAddress
      user.headline = auth.extra.raw_info.headline
      user.industry = auth.extra.raw_info.industry
      api = LinkedIn::API.new(user.access_token)
      our_hash = api.profile(fields:["id", {"positions" => ["title", {"company" => ["name"]}]}])
      user.company = our_hash.positions.all[0].company.name
      user.title = our_hash.positions.all[0].title
      user.save!
      user
    end

    def notes_for_user
      authored_notes.where(user: @user)
    end

end
