json.array!(@events) do |event|
  json.extract! event, :id, :name, :location, :city, :state, :zipcoe, :description, :time, :date
  json.url event_url(event, format: :json)
end
