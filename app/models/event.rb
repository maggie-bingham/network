class Event < ActiveRecord::Base
  has_many :event_members, :as => :attendable
  has_many :users, :through => :event_members, :source => :invitable, :source_type => "User"

  acts_as_mappable :default_units => :miles,
                                     :default_formula => :sphere,
                                     :distance_field_name => :distance,
                                     :lat_column_name => :lat,
                                     :lng_column_name => :lon


  def self.key
    RMeetup::Client.api_key = "MEETUP_KEY"
    results = RMeetup::Client.fetch(:results)
  end

  def self.param(lat,lon)
      { category: '22',
      lat:  lat,
      lon:  lon,
      radius: '30',
      format:   'json'}
  end

  def self.results(lat, lon)
    event_data = MeetupApi.new.open_events(param(lat, lon))["results"]
    if event_data.blank?
      within(30, :origin => [lat, lon])
    else
      Rails.logger.info(event_data.inspect)
      event_external_ids = event_data.map{ |event| event["id"]}
      Rails.logger.info event_external_ids.inspect
      events = event_data.map do |event|
        Rails.logger.info event.keys.inspect
        Rails.logger.info event["venue"].inspect
        u = Event.find_or_initialize_by(:external_id => event["id"])
        u.external_id = event["id"]
        u.group_name = event["group"]["name"]
        u.date = Time.at(event["time"]/1000)
        u.description = event["description"] || ""
        u.venue_name = event["venue"] ? event["venue"]["name"] : ""
        u.address = event["venue"] ? event["venue"]["address_1"] : ""
        u.city = event["venue"] ? event["venue"]["city"] : ""
        u.state = event["venue"] ? event["venue"]["state"] : ""
        u.zipcode = event["venue"] ? event["venue"]["zip"] : ""
        u.lat = event["venue"] ? event["venue"]["lat"] : 0
        u.lon = event["venue"] ? event["venue"]["lon"] : 0
        u.urlname = event["group"]["urlname"]
        if u.urlname.blank?
          res = JSON.parse ApiCallers::HttpRequest.new("http://api.meetup.com/#{u.urlname}?key=#{MeetupClient.config.api_key}").make_request
          if res["photos"]
            u.image_url = res["photos"].select{|photo| photo.has_key?("photo_link")}.first["photo_link"]
          end
        end
        u.save!
        u
      end
    end
  end

end
