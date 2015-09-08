class Event < ActiveRecord::Base
  # acts_as_attendable :event_members, by: :users

  def self.param
    { category: '2',
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
        u.save
        u
    end
    events.select(&:persisted?)
  end

end
