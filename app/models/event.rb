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
      { category: '2',
      lat:  lat,
      lon:  lon,
      radius: '30',
      format:   'json'}
  end

  def self.results(lat, lon)
     event_data = MeetupApi.new.open_events(param(lat, lon))["results"]
     events = event_data.map do |event|
       Rails.logger.info event.inspect
         u = Event.find_or_initialize_by(:external_id => event["id"])
         u.external_id = event["id"]
         u.group_name = event["group"]["name"]
         u.date = Time.at(event["time"]/1000)
         u.description = event["description"] || ""
         u.venue_name = event["venue"].try('["name"]'.to_sym) || ""
         u.address = event["venue"].try('["address_1"]'.to_sym) || ""
         u.city = event["venue"].try('["city"]'.to_sym) || ""
         u.state = event["venue"].try('["state"]'.to_sym) || ""
         u.zipcode = event["venue"].try('["zip"]'.to_sym) || ""
         u.lat = event["venue"].try('["lat"]'.to_sym) || 0
         u.lon = event["venue"].try('["lon"]'.to_sym) || 0
         u.save!
         u
     end
    events.select(&:persisted?)

  end

  def categories
    cat = MeetupApi.new.categories({})["results"]

  end


end
