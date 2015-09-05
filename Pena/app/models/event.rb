class Event < ActiveRecord::Base

  def meetup
    MeetupApi.new
    Rails.logger.info auth.to_yaml

  end

  def events
    RMeetup::Client.api_key = "MEETUP_KEY"
    results = RMeetup::Client.fetch(:results)


  end

  def details
    api_response = events()
  end


end
