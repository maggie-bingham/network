class Event < ActiveRecord::Base

  def self.key
    RMeetup::Client.api_key = "MEETUP_KEY"
    results = RMeetup::Client.fetch(:results)
  end

  # def details
  #   api_response = events()
  # end

  def self.param
    { category: '2',
               country: 'us',
               state:    'IN',
               city:     'Indianapolis',
               format:   'json'}

  end

  def self.results
    MeetupApi.new.open_events(param)["results"]
  end

  def event_name

  end

  def group_name
  end

  def event_desc

  end

  def venue_name
    gn = meetup.open_events(param)["results"]
     gn.find {|x| x['venue']['state']== 'CA'}
  end

end
