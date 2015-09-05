

def response
  `curl "https://api.meetup.com/2/open_events?&&key=MEETUP_KEY&&sign=true" `
end

def parsed
  JSON.parse(response)
end


data = reponse.parsed


data[:results][:venue].each do |meetup|
  Event.create(city:        meetup["city"],
               address:     meetup["address"],
               lon:         meetup["lon"],
               lat:         meetup["lat"],
               state:       meetup["state"])
end


data[:results][:venue].each do |meetup|
  Event.create(description: meetup["description"],
               name:        meetup["name"],
end

  # (position_title: house["position_title"],
