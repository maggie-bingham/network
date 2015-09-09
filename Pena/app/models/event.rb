class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  acts_as_mappable :default_units => :miles,
                                     :default_formula => :sphere,
                                     :distance_field_name => :distance,
                                     :lat_column_name => :lat,
                                     :lng_column_name => :lon


  def self.key
    RMeetup::Client.api_key = "MEETUP_KEY"
    results = RMeetup::Client.fetch(:results)
  end

  def self.param
    { category: '2 , 21',
      country:  'US',
      state:    'IN',
      city:     'Indianapolis',
      format:   'json'}
  end

  def self.results
    event_data = MeetupApi.new.open_events(param)["results"]
    events = event_data.map do |event|
        u = Event.new
        u.external_id = event["id"]
        u.group_name = event["group"]["name"]
        u.date = Time.at(event["time"]/1000).strftime("%B %d, %Y %I:%M %p").to_s
        u.description = event["description"]
        u.venue_name = event["venue"]["name"]
        u.address = event["venue"]["address_1"]
        u.city = event["venue"]["city"]
        u.state = event["venue"]["state"]
        u.zipcode = event["venue"]["zip"]
        u.lat = event["venue"]["lat"]
        u.lon = event["venue"]["lon"]
        u.save
        u
    end
    events.select(&:persisted?)

  end


end
