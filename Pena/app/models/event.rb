class Event < ActiveRecord::Base

  def meetup_api
    MeetupApi.new
  end

  def events
    meetup_api.categories(params)
  end

  def details
    api_response = meetup_api
  end

private

  def categories(params)
    params.require(:events).permit(:lat, :lon, :city, :state, :name, :description, :picture, :time)
  end
end
