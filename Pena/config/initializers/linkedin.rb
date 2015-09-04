LinkedIn.configure do |config|
  config.client_id = ENV["LINKEDIN_KEY"]
  config.client_secret = ENV["LINKEDIN_SECRET"]
end
