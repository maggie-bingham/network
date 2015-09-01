json.array!(@events) do |event|
  json.extract! event, :id, :name, :location, :description, :time, :date
  json.url event_url(event, format: :json)
end
