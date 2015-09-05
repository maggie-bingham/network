class Event < ActiveRecord::Base

  def meetup
    MeetupApi.new
    Rails.logger.info auth.to_yaml

  end

  def events
    meetup_api = MeetupAPI.new
    events = meetup_api.categories({})
  end

  def details
    api_response = events()
  end


end
