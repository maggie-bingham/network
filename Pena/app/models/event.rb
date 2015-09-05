class Event < ActiveRecord::Base

  def meetup
    MeetupApi.new
  end

  def events
    meetup_api.open_events()
  end

  def details
    api_response = events()
  end


end
