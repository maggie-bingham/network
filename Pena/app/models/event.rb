class Event < ActiveRecord::Base

  def meetup_api
    MeetupApi.new
  end

  def events
    meetup_api.open_events(HASH)
  end

  def details
    api_response = events()
  end


end
