class Event < ActiveRecord::Base

  def self.param
    { category: '2',
      country: 'us',
      city:   'Indianapolis',
      state:    'IN',
      format:   'json'}
  end

  def self.results
    MeetupApi.new.open_events(param)['results']
  end

  def information
    category.event_name = ['name']
    category.event.group_name = ['group']['name']
    category.event.event_description = ['description']
    category.event.venue_name = ['venue']['name']
    category.event.venue_address = ['venue']['address_1']
    category.event.venue_city = ['venue']['city']
    category.event.venue_state = ['venue']['state']
    category.event.venue_zip = ["results"]['venue']['zip']
    category.event.event_url = ['event_url']
  end

  def location
    latitude = ['results']['venue']['lat']
    longitude = ['results']['venue']['lon']
  end

end
