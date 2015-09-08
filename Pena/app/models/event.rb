class Event < ActiveRecord::Base

  def self.param
    { category: '2',
      country:  'US',
      state:    'IN',
      city:     'Indianapolis',
      format:   'json'}
  end

  def self.results
    event_data = JSON.parse(MeetupApi.new.open_events(self.param)["results"])
    event = event_data.map do |event|
      u = Event.new
      u.external_id = event["id"]
      u.event_name = event.slice["group"]["name"]
  end

end
