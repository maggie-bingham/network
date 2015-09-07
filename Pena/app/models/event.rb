class Event < ActiveRecord::Base


  def from_meetup

  end
  def meetup
    MeetupApi.new
  end

  def key
    RMeetup::Client.api_key = "MEETUP_KEY"
    results = RMeetup::Client.fetch(:results)
  end

  # def details
  #   api_response = events()
  # end

  def param
    { category: '2',
               country: 'us',
               city:   'Indianapolis',
               state:    'IN',
               format:   'json'}

  end

  def results
    meetup.open_events(param)["results"]
  end

  def events
   results[0].count
  end

  def categories
    meetup.categories({})
  end




end




  # ["results"][0]
